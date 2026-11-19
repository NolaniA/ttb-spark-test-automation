# url
DOMAIN = "the-internet.herokuapp.com"
PATH_LOGIN = "/login"
PATH_AUTHEN = "/authenticate"
PATH_SECURE = "/secure"
PATH_LOGOUT = "/logout"
BASE_URL = f"http://{DOMAIN}"

# variable
RESPONSE_LOGOUT = {}
RESPONSE_AUTH = {}

BROWSER = "Chromium"
BROWSER_TIMEOUT = 15
HEADLESS = False

MESSAGE_LOGOUT = 'You logged out of the secure area!'
MESSAGE_SUCCESS = 'You logged into a secure area!'
MESSAGE_PASSWORD_FAILED_LOGIN = 'Your password is invalid!'
MESSAGE_USERNAME_FAILED_LOGIN = 'Your username is invalid!'

USER = {
    "success" : {
        "username" : "tomsmith",
        "password" : "SuperSecretPassword!"
    },
    "invalid_password" : {
        "username" : "tomsmith",
        "password" : "Password!"
    },
    "invalid_username" : {
        "username" : "tomholland",
        "password" : "SuperSecretPassword!"
    },
}

SELECTOR = {
    "form_login" : "form#login",
    "input_username" : "input#username",
    "input_password" : "input#password",
    "button_login" : "button[type='submit']",
    "button_logout" : 'a[href="/logout"]',
    "flash_messages" : "div[data-alert]", #div.flash.success
}

