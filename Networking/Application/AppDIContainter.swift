//
//  AppDIContainter.swift
//  Networking
//
//  Created by Егор Бадмаев on 15.07.2022.
//

import Foundation

final class AppDIContainter: NSObject {
    
    private let networkManager: NetworkManager = {
        let configuration = URLSessionConfiguration.default
        var urlSession = URLSession(configuration: configuration)
        let networkManager = NetworkManager(session: urlSession)
        return networkManager
    }()
    
    /**
     Background URLSession, в отличие от обычной, работает вне процесса приложения, где-то внутри системы, поэтому она не «умирает», когда завершается процесс приложения.
     Называется она background-сессией (также, как и состояние приложения) и требует специфической настройки.
     */
    private lazy var backgroundUrlSession: URLSession = {
        /**
         `identifier` (передаётся в инициализаторе) — это строка, которая используется для сопоставления background сессий при перезапуске приложения.
         Если приложение перезапустилось, и вы создаёте background сессию уже с использующимся в другой background сессии идент-ром, новая получит доступ к задачам предыдущей.
         Для корректной работы нужно, чтобы этот идентификатор был уникальный для вашего приложения и постоянный (можно использовать, например, производную от `bundleId` приложения);
         */
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: Bundle.main.bundleIdentifier ?? "com.networking.app")
        /// Указывает, должно ли приложение быть возобновлено или запущено в фоновом режиме после завершения передачи данных
        backgroundConfiguration.sessionSendsLaunchEvents = true
        /// Даёт возможность системе планировать выполнение задачи более редко. С одной стороны, экономит заряд аккумулятора, с другой - может затормозить выполнение задачи.
        backgroundConfiguration.isDiscretionary = true
        /// Показывает, что можно использовать сотовую связь для работы с сетью (судя по отзывам, разложено огромное количество граблей)
        backgroundConfiguration.allowsCellularAccess = true
        /// Показывает, что система дольше должна сохранять коннект с сервером, когда приложение уходит в фон. В противном случае коннект будет разорван.
        backgroundConfiguration.shouldUseExtendedBackgroundIdleMode = true
        /// В условиях мобильного устройства связь может пропадать на короткие промежутки времени. Созданные в этот момент задачи могут либо быть приостановлены до появления связи, либо сразу вернуть ошибку _«нет связи»_. Параметр позволяет управлять этим поведением. Если он `false`, то при отсутствии связи задача сразу же сломается с ошибкой. Если `true` — подождёт, пока не появится связь.
        backgroundConfiguration.waitsForConnectivity = true
        var backgroundUrlSession = URLSession(configuration: backgroundConfiguration, delegate: self, delegateQueue: nil)
        return backgroundUrlSession
    }()
    
    /// Упростил, ибо это тут не столь важно
    func start() -> NetworkManagerProtocol {
        return networkManager
    }
}

/**
 Есть два способа получения событий от задачи/от сессии. Первый — callback
 ```
 session.dataTask(with: request) { data, response, error in
     // ... обрабатываем результат
 }
 ```
 В этом случае событие завершения задачи будет отправлено в замыкание, где нужно проверить, нет ли ошибки, что в ответе и какие данные пришли.
 
 Второй вариант работы с сессией — через delegate. В этом случае мы должны создать класс, который реализует протоколы `URLSessionDataDelegate` и (или) другие рядом стоящие (для разных типов задач протоколы немного отличаются). Ссылка на экземпляр этого класса живёт в сессии, а его методы вызываются при необходимости передачи в делегат событий. Прописать ссылку в сессии можно инициализатором. В примере прописывается `self`.

 `URLSession(configuration: configuration, delegate: self, delegateQueue: nil)`

 Для обычных сессий доступны оба метода. Background сессии умеют использовать только делегат.
 */
extension AppDIContainter: URLSessionDelegate {
}
