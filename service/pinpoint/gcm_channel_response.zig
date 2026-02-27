/// Provides information about the status and settings of the GCM channel for an
/// application. The GCM channel enables Amazon Pinpoint to send push
/// notifications through the Firebase Cloud Messaging (FCM), formerly Google
/// Cloud Messaging (GCM), service.
pub const GCMChannelResponse = struct {
    /// The unique identifier for the application that the GCM channel applies to.
    application_id: ?[]const u8,

    /// The date and time when the GCM channel was enabled.
    creation_date: ?[]const u8,

    /// The Web API Key, also referred to as an *API_KEY* or *server key*, that you
    /// received from Google to communicate with Google services.
    credential: ?[]const u8,

    /// The default authentication method used for GCM. Values are either "TOKEN" or
    /// "KEY". Defaults to "KEY".
    default_authentication_method: ?[]const u8,

    /// Specifies whether the GCM channel is enabled for the application.
    enabled: ?bool,

    /// (Not used) This property is retained only for backward compatibility.
    has_credential: ?bool,

    /// Returns true if the JSON file provided by Google during registration process
    /// was used in the **ServiceJson** field of the request.
    has_fcm_service_credentials: ?bool,

    /// (Deprecated) An identifier for the GCM channel. This property is retained
    /// only for backward compatibility.
    id: ?[]const u8,

    /// Specifies whether the GCM channel is archived.
    is_archived: ?bool,

    /// The user who last modified the GCM channel.
    last_modified_by: ?[]const u8,

    /// The date and time when the GCM channel was last modified.
    last_modified_date: ?[]const u8,

    /// The type of messaging or notification platform for the channel. For the GCM
    /// channel, this value is GCM.
    platform: []const u8,

    /// The current version of the GCM channel.
    version: ?i32,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .creation_date = "CreationDate",
        .credential = "Credential",
        .default_authentication_method = "DefaultAuthenticationMethod",
        .enabled = "Enabled",
        .has_credential = "HasCredential",
        .has_fcm_service_credentials = "HasFcmServiceCredentials",
        .id = "Id",
        .is_archived = "IsArchived",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .platform = "Platform",
        .version = "Version",
    };
};
