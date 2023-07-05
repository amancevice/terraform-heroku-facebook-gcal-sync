terraform {
  required_version = "~> 1.0"

  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 5.2"
    }
  }
}

resource "heroku_addon" "scheduler" {
  app_id = heroku_app.app.id
  plan   = var.scheduler_plan
}

resource "heroku_addon" "papertrail" {
  app_id = heroku_app.app.id
  plan   = var.papertrail_plan
}

resource "heroku_app" "app" {
  name       = var.app_name
  region     = var.app_region
  stack      = var.app_stack
  buildpacks = var.app_buildpacks

  config_vars = {
    FACEBOOK_PAGE_ID       = var.facebook_page_id
    GOOGLE_CALENDAR_ID     = var.google_calendar_id
    FACEBOOK_PAGE_TOKEN    = var.facebook_page_token
    GOOGLE_SERVICE_ACCOUNT = filebase64(var.google_credentials_file)
  }
}

resource "heroku_app_release" "release" {
  app_id  = heroku_app.app.id
  slug_id = heroku_build.build.slug_id
}

resource "heroku_build" "build" {
  app_id = heroku_app.app.id

  source {
    url     = "https://github.com/amancevice/terraform-heroku-facebook-gcal-sync/archive/${var.app_version}.tar.gz"
    version = var.app_version
  }
}
