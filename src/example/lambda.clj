(ns example.lambda
  (:gen-class
   :implements [com.amazonaws.services.lambda.runtime.RequestStreamHandler]))

(defn -handleRequest [this is os context]
  (println "Hello World!")
  )
