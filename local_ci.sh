source './fastlane/.env.Gigsterous' && echo -e "machine bitbucket.org\n  login $BITBUCKET_USER\n  password $BITBUCKET_PASSWORD" >> ~/.netrc;
fastlane beta --env Gigsterous;
rm -f ~/.netrc;
