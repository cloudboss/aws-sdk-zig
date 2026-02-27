/// Provides information about the status and settings of the APNs (Apple Push
/// Notification service) VoIP sandbox channel for an application.
pub const APNSVoipSandboxChannelResponse = struct {
    /// The unique identifier for the application that the APNs VoIP sandbox channel
    /// applies to.
    application_id: ?[]const u8,

    /// The date and time when the APNs VoIP sandbox channel was enabled.
    creation_date: ?[]const u8,

    /// The default authentication method that Amazon Pinpoint uses to authenticate
    /// with the APNs sandbox environment for this channel, key or certificate.
    default_authentication_method: ?[]const u8,

    /// Specifies whether the APNs VoIP sandbox channel is enabled for the
    /// application.
    enabled: ?bool,

    /// (Not used) This property is retained only for backward compatibility.
    has_credential: ?bool,

    /// Specifies whether the APNs VoIP sandbox channel is configured to communicate
    /// with APNs by using APNs tokens. To provide an authentication key for APNs
    /// tokens, set the TokenKey property of the channel.
    has_token_key: ?bool,

    /// (Deprecated) An identifier for the APNs VoIP sandbox channel. This property
    /// is retained only for backward compatibility.
    id: ?[]const u8,

    /// Specifies whether the APNs VoIP sandbox channel is archived.
    is_archived: ?bool,

    /// The user who last modified the APNs VoIP sandbox channel.
    last_modified_by: ?[]const u8,

    /// The date and time when the APNs VoIP sandbox channel was last modified.
    last_modified_date: ?[]const u8,

    /// The type of messaging or notification platform for the channel. For the APNs
    /// VoIP sandbox channel, this value is APNS_VOIP_SANDBOX.
    platform: []const u8,

    /// The current version of the APNs VoIP sandbox channel.
    version: ?i32,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .creation_date = "CreationDate",
        .default_authentication_method = "DefaultAuthenticationMethod",
        .enabled = "Enabled",
        .has_credential = "HasCredential",
        .has_token_key = "HasTokenKey",
        .id = "Id",
        .is_archived = "IsArchived",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .platform = "Platform",
        .version = "Version",
    };
};
