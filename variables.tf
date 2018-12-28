variable heroku_email {
  description = "Heroku account email."
  default     = ""
}

variable heroku_api_key {
  description = "Heroku account API key."
  default     = ""
}

variable app_name {
  description = "Heroku app name."
}

variable app_region {
  description = "Heroku app region."
  default     = "us"
}

variable app_stack {
  description = "Heroku app stack."
  default     = "heroku-18"
}

variable app_buildpacks {
  description = "Heroku app buildpacks."
  default     = ["heroku/python"]
  type        = "list"
}

variable facebook_page_id {
  description = "facebook page ID."
}

variable google_calendar_id {
  description = "Google Calendar ID."
}

variable facebook_page_token {
  description = "facebook page access token."
}

variable google_credentials_file {
  description = "Google Service account credentials file path."
}

variable scheduler_plan {
  description = "Heroku scheduler addon plan."
  default     = "scheduler:standard"
}

variable papertrail_plan {
  description = "PaperTrail add on plan."
  default     = "papertrail:choklad"
}

variable version {
  description = "Version of module."
  default     = "0.1.0"
}
