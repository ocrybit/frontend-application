#!/usr/bin/env bash
set -e

# SSMからNuxtのビルドに必要な値を取得し、環境変数へ格納
# exportと一緒に記述すると、exportは成功とみなされてSSMの取得が失敗した場合でもスクリプトが継続してしまう
# 値の取得に失敗した際には終了させたいので、2行に取得処理を分けている
ALIS_APP_DOMAIN=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmAlisAppDomain --query "Parameter.Value" --output text`
export ALIS_APP_DOMAIN=${ALIS_APP_DOMAIN}
BASE_URL=https://${ALIS_APP_DOMAIN}
export BASE_URL=${BASE_URL}
COGNITO_USER_POOL_ID=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmCognitoUserPoolId --query "Parameter.Value" --output text`
export COGNITO_USER_POOL_ID=${COGNITO_USER_POOL_ID}
COGNITO_APP_CLIENT_ID=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmCognitoUserPoolAppId --query "Parameter.Value" --output text`
export COGNITO_APP_CLIENT_ID=${COGNITO_APP_CLIENT_ID}
DIST_S3_BUCKET_NAME=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmDistS3BucketName --query "Parameter.Value" --output text`
export DIST_S3_BUCKET_NAME=${DIST_S3_BUCKET_NAME}
IFRAMELY_API_KEY=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmIframelyApiKey --query "Parameter.Value" --output text`
export IFRAMELY_API_KEY=${IFRAMELY_API_KEY}
PUBLIC_CHAIN_BRIDGE_ADDRESS=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmPublicChainBridgeAddress --query "Parameter.Value" --output text`
export PUBLIC_CHAIN_BRIDGE_ADDRESS=${PUBLIC_CHAIN_BRIDGE_ADDRESS}
PUBLIC_CHAIN_ALIS_TOKEN_ADDRESS=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmPublicChainAlisTokenAddress --query "Parameter.Value" --output text`
export PUBLIC_CHAIN_ALIS_TOKEN_ADDRESS=${PUBLIC_CHAIN_ALIS_TOKEN_ADDRESS}
PUBLIC_CHAIN_REGISTRY_ADDRESS=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmPublicChainRegistryAddress --query "Parameter.Value" --output text`
export PUBLIC_CHAIN_REGISTRY_ADDRESS=${PUBLIC_CHAIN_REGISTRY_ADDRESS}
PUBLIC_CHAIN_LICENSE_TOKEN_ADDRESS=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmPublicChainLicenseTokenAddress --query "Parameter.Value" --output text`
export PUBLIC_CHAIN_LICENSE_TOKEN_ADDRESS=${PUBLIC_CHAIN_LICENSE_TOKEN_ADDRESS}
PUBLIC_CHAIN_OPERATION_URL=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmPublicChainOperationUrl --query "Parameter.Value" --output text`
export PUBLIC_CHAIN_OPERATION_URL=${PUBLIC_CHAIN_OPERATION_URL}
DAILY_LIMIT_TOKEN_SEND_VALUE=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmDailyLimitTokenSendValue --query "Parameter.Value" --output text`
export DAILY_LIMIT_TOKEN_SEND_VALUE=${DAILY_LIMIT_TOKEN_SEND_VALUE}
SENTRY_DSN=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmSentryDSN --query "Parameter.Value" --output text`
export SENTRY_DSN=${SENTRY_DSN}
SENTRY_RELEASE=`git rev-parse HEAD`
export SENTRY_RELEASE=${SENTRY_RELEASE}
COGNITO_IDENTITY_POOL_ID=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmCognitoIdentityPoolId --query "Parameter.Value" --output text`
export COGNITO_IDENTITY_POOL_ID=${COGNITO_IDENTITY_POOL_ID}
ALL_TOKEN_HISTORY_CSV_DWONLOAD_S3_BUCKET=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmAllTokenHistoryCsvDownloadS3Bucket --query "Parameter.Value" --output text`
export ALL_TOKEN_HISTORY_CSV_DWONLOAD_S3_BUCKET=${ALL_TOKEN_HISTORY_CSV_DWONLOAD_S3_BUCKET}
export WEB3_SERVICE_BASE_URL=`aws ssm get-parameter --name ${ALIS_APP_ID}ssmWeb3ServiceBaseUrl --query "Parameter.Value" --output text`

if [ $1 = 'ci' ];then
  yarn nuxt build --config-file nuxt.config.ci.js
else
  yarn nuxt build
fi
