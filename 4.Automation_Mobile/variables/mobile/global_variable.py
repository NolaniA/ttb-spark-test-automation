

REMOTE_URL = "http://127.0.0.1:4723"
PLATFORM_NAME = "Android"
AUTOMATION_NAME = "UiAutomator2"
DEVICE_NAME = "Pixel 5 API 30"
DEVICE_UDID = "emulator-5554"  # Verify with: adb devices

APP_PACKAGE = "com.avjindersinghsekhon.minimaltodo"
APP_ACTIVITY = "com.example.avjindersinghsekhon.toodle.MainActivity"
APP_WAIT_ACTIVITY = "com.example.avjindersinghsekhon.toodle.*"
NO_RESET = False  # New session starts with a fresh app state; restart stays in same session
DEFAULT_TIMEOUT = 15

# Using Appium 2 W3C capability syntax; no APK path is needed because already installed.
APPIUM_OPTIONS = {
    "automationName": AUTOMATION_NAME,
    "deviceName": DEVICE_NAME,
    "udid": DEVICE_UDID,
    "appPackage": APP_PACKAGE,
    "appActivity": APP_ACTIVITY,
    "appWaitActivity": APP_WAIT_ACTIVITY,
    "noReset": NO_RESET,
}

SELECTOR = {
    "add_task_fab": f"id={APP_PACKAGE}:id/addToDoItemFAB",
    "input_title": f"id={APP_PACKAGE}:id/userToDoEditText",
    "save_task_fab": f"id={APP_PACKAGE}:id/makeToDoFloatingActionButton",
    "reminder_switch": f"id={APP_PACKAGE}:id/toDoHasDateSwitchCompat",
    "list_recyclerview": f"id={APP_PACKAGE}:id/toDoRecyclerView",
    "list_item_title": f"id={APP_PACKAGE}:id/toDoListItemTextview",
    "empty_view": f"id={APP_PACKAGE}:id/toDoEmptyView",
    # Not confirmed in the three XML snapshots; inspect a visible Snackbar to verify.
    "snackbar_undo": f"id={APP_PACKAGE}:id/snackbar_action",
}

TEST_DATA = {
    "long_title": "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
    "max_title_length": 30,
}