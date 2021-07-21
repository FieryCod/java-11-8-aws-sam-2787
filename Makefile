BUCKET_NAME=aws-sam2787-test-v1
STACK_NAME:=test


test:
	@echo "Invoking Clojure on Java8. I will not fail!"
	@sam local invoke ClojureOnJava8
	@echo "Invoking Clojure on Java11. I will fail!"
	@sam local invoke ClojureOnJava11

build: java8.jar java11.jar
	bash -c "source $(SDKMAN_DIR)/bin/sdkman-init.sh && \
		sdk use java 8.292.10.1-amzn && \
		lein uberjar && mv target/latest.jar java8.jar  && \
		sdk use java 11.0.11.9.1-amzn && \
		lein uberjar && mv target/latest.jar java11.jar"

deploy: build
	@aws s3 ls s3://$(BUCKET_NAME) || aws s3 mb s3://$(BUCKET_NAME)
	@sam package --template-file template.yml --output-template-file packaged.yml --s3-bucket $(BUCKET_NAME)
	@sam deploy  --template-file packaged.yml --stack-name $(STACK_NAME) --capabilities CAPABILITY_IAM --region eu-central-1 --s3-bucket $(BUCKET_NAME)

destroy:
	@aws cloudformation delete-stack --stack-name $(STACK_NAME) --region eu-central-1
