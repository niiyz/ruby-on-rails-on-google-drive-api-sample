# Google Drive API v3 Sample

- Service Account

```.env
GOOGLE_ACCOUNT_TYPE=service_account
GOOGLE_CLIENT_ID=123456789000000000
GOOGLE_CLIENT_EMAIL=google-drive-sample@gxxxxx-xxxxxx-111111.iam.gserviceaccount.com
GOOGLE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n ..... \n\n-----END PRIVATE KEY-----\n"

DRIVE_ACCOUNT_EMAIL=yoshida@niiyz.com
```

### Start
```
docker-compose up

docker-compose run web rake db:create
docker-compose run web rails db:migrate

access to http://localhost:3000/file
```


