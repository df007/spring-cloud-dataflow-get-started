ORG=pcfdev-org
SPACE=pcfdev-space
USER=admin
PASS=admin
APP_DOMAIN=local.pcfdev.io
SYS_DOMAIN=$APP_DOMAIN


cf create-service p-redis shared-vm redis
cf create-service p-rabbitmq  standard rabbit
cf push dataflow-server --no-start -p spring-cloud-dataflow-server-cloudfoundry-1.0.0.BUILD-SNAPSHOT.jar -m 1G
cf bind-service dataflow-server redis
cf bind-service dataflow-server rabbit
cf set-env dataflow-server spring.cloud.deployer.cloudfoundry.url https://api.$SYS_DOMAIN
cf set-env dataflow-server spring.cloud.deployer.cloudfoundry.org $ORG
cf set-env dataflow-server spring.cloud.deployer.cloudfoundry.space $SPACE
cf set-env dataflow-server spring.cloud.deployer.cloudfoundry.domain $APP_DOMAIN
cf set-env dataflow-server spring.cloud.deployer.cloudfoundry.services redis,rabbit
cf set-env dataflow-server spring.cloud.deployer.cloudfoundry.username $USER
cf set-env dataflow-server spring.cloud.deployer.cloudfoundry.password $PASS
cf set-env dataflow-server spring.cloud.deployer.cloudfoundry.skipSslValidation true
cf set-env dataflow-server spring.cloud.deployer.cloudfoundry.buildpack java_buildpack
cf set-env dataflow-server spring.cloud.deployer.cloudfoundry.memory  256
cf set-env dataflow-server spring.cloud.deployer.cloudfoundry.disk  512

cf start dataflow-server
