/// Specifies the status and settings of the GCM channel for an application.
/// This channel enables Amazon Pinpoint to send push notifications through the
/// Firebase Cloud Messaging (FCM), formerly Google Cloud Messaging (GCM),
/// service.
pub const GCMChannelRequest = struct {
    /// The Web API Key, also referred to as an *API_KEY* or *server key*, that you
    /// received from Google to communicate with Google services.
    api_key: ?[]const u8,

    /// The default authentication method used for GCM. Values are either "TOKEN" or
    /// "KEY". Defaults to "KEY".
    default_authentication_method: ?[]const u8,

    /// Specifies whether to enable the GCM channel for the application.
    enabled: ?bool,

    /// The contents of the JSON file provided by Google during registration in
    /// order to generate an access token for authentication. For more information
    /// see [Migrate from legacy FCM APIs to HTTP
    /// v1](https://firebase.google.com/docs/cloud-messaging/migrate-v1).
    service_json: ?[]const u8,

    pub const json_field_names = .{
        .api_key = "ApiKey",
        .default_authentication_method = "DefaultAuthenticationMethod",
        .enabled = "Enabled",
        .service_json = "ServiceJson",
    };
};
