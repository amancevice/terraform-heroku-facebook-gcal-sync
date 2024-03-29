import base64
import json
import logging
import os

import facebook
import fest
from google.oauth2 import service_account
from googleapiclient import discovery

DRYRUN = str(os.getenv("DRYRUN")).lower() in ["true", "1"]
FACEBOOK_PAGE_ID = os.environ["FACEBOOK_PAGE_ID"]
GOOGLE_CALENDAR_ID = os.environ["GOOGLE_CALENDAR_ID"]

# Get facebook/Google secrets
FACEBOOK_PAGE_TOKEN = os.environ["FACEBOOK_PAGE_TOKEN"]
GOOGLE_SERVICE_ACCOUNT = json.loads(
    base64.b64decode(os.environ["GOOGLE_SERVICE_ACCOUNT"]).decode()
)
GOOGLE_CREDENTIALS = service_account.Credentials.from_service_account_info(
    GOOGLE_SERVICE_ACCOUNT
)

# Get facebook/Google clients
GRAPHAPI = facebook.GraphAPI(FACEBOOK_PAGE_TOKEN)
CALENDARAPI = discovery.build(
    "calendar",
    "v3",
    cache_discovery=False,
    credentials=GOOGLE_CREDENTIALS,
)

# Configure logging
logging.basicConfig(format="%(name)s - %(levelname)s - %(message)s")


def main(page_id=None, cal_id=None, dryrun=False):
    page_id = page_id or FACEBOOK_PAGE_ID
    cal_id = cal_id or GOOGLE_CALENDAR_ID

    # Initialize facebook page & Google Calendar
    page = fest.FacebookPage(GRAPHAPI, page_id)
    gcal = fest.GoogleCalendar(CALENDARAPI, cal_id)
    page.logger.setLevel("INFO")
    gcal.logger.setLevel("INFO")

    # Sync
    sync = gcal.sync(page, time_filter="upcoming").execute(dryrun=dryrun)

    # Return referces to modified objects
    resp = {
        k: [
            {
                "google_id": x.get("id"),
                "location": x.get("location"),
                "summary": x.get("summary"),
                "htmlLink": x.get("htmlLink"),
                "start": event_time(x.get("start")),
                "end": event_time(x.get("end")),
            }
            for facebook_id, x in v.items()
        ]
        for k, v in sync.responses.items()
    }
    return resp


def event_time(time):
    try:
        return time["dateTime"]
    except KeyError:
        return time["date"]


if __name__ == "__main__":
    print(json.dumps(main(), indent=2, sort_keys=True))
