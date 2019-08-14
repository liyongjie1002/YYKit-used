#! /bin/bash
echo '开始验证'
pod spec lint YYKit-used.podspec --use-libraries --allow-warnings --verbose
echo '开始推送'
pod trunk push YYKit-used.podspec --allow-warnings --use-libraries --verbose
