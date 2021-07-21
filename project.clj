(defproject my-lambda-project "0.1.0-SNAPSHOT"
  :description "Example lambada project."
  :dependencies [[org.clojure/clojure                              "1.10.3"]
                 [com.amazonaws/aws-lambda-java-core               "1.2.1"]]
  :profiles {:uberjar {:aot :all}}
  :uberjar-name "latest.jar")
