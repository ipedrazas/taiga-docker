config = {
    host: "${hostname}"
    scheme: "${scheme}"

    debug: true

    defaultLanguage: "en"
    languageOptions: {
        "en": "English"
    }

    publicRegisterEnabled: false
    privacyPolicyUrl: null
    termsOfServiceUrl: null
}

angular.module("taigaLocalConfig", []).value("localconfig", config)