# Facebook to Google Calendar Sync

[![terraform](https://img.shields.io/github/v/tag/amancevice/terraform-heroku-facebook-gcal-sync?color=62f&label=version&logo=terraform&style=flat-square)](https://registry.terraform.io/modules/amancevice/serverless-pypi/aws)

Synchronize facebook page events with Google Calendar.

## Prerequisites

Before beginning you will need to create and configure a [facebook app](https://github.com/amancevice/fest/blob/master/docs/facebook.md#facebook) and use it to acquire a page access token for Graph API.

You will also need to set up a Google [service account](https://github.com/amancevice/fest/blob/master/docs/google.md#google) to acquire a credentials file to authenticate with Google APIs.

## Usage

Collect your facebook Page access token and Google service account credentials file.

```terraform
module "facebook_gcal_sync" {
  source                  = "amancevice/facebook-gcal-sync/heroku"
  version                 = "~> 1.0"
  app_name                = "<unique-app-name"
  facebook_page_id        = "<facebook-page-id>"
  google_calendar_id      = "<google-calendar-id>"
  google_credentials_file = "<path-to-google-service-credentials>"
  facebook_page_token     = "<facebook-page-access-token>"
}
```

Once the app is created, configure the scheduler to run on a cron through the [heroku dashboard](https://dashboard.heroku.com/apps).
