# Facebook to Google Calendar Sync

Synchronize facebook page events with Google Calendar.

## Usage

Collect your facebook Page access token and Google service account credentials file.

```hcl
module facebook_gcal_sync {
  source                  = "amancevice/facebook-gcal-sync/heroku"
  app_name                = "<unique-app-name"
  facebook_page_id        = "<facebook-page-id>"
  google_calendar_id      = "<google-calendar-id>"
  google_credentials_file = "<path-to-google-service-credentials>"
  facebook_page_token     = "<facebook-page-access-token>"
}
```

Once the app is created, configure the scheduler to run on a cron through the [heroku dashboard](https://dashboard.heroku.com/apps).
