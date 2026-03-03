/// Provides information about the status and settings of the APNs (Apple Push
/// Notification service) channel for an application.
pub const APNSChannelResponse = struct {
    /// The unique identifier for the application that the APNs channel applies to.
    application_id: ?[]const u8 = null,

    /// The date and time when the APNs channel was enabled.
    creation_date: ?[]const u8 = null,

    /// The default authentication method that Amazon Pinpoint uses to authenticate
    /// with APNs for this channel, key or certificate.
    default_authentication_method: ?[]const u8 = null,

    /// Specifies whether the APNs channel is enabled for the application.
    enabled: ?bool = null,

    /// (Not used) This property is retained only for backward compatibility.
    has_credential: ?bool = null,

    /// Specifies whether the APNs channel is configured to communicate with APNs by
    /// using APNs tokens. To provide an authentication key for APNs tokens, set the
    /// TokenKey property of the channel.
    has_token_key: ?bool = null,

    /// (Deprecated) An identifier for the APNs channel. This property is retained
    /// only for backward compatibility.
    id: ?[]const u8 = null,

    /// Specifies whether the APNs channel is archived.
    is_archived: ?bool = null,

    /// The user who last modified the APNs channel.
    last_modified_by: ?[]const u8 = null,

    /// The date and time when the APNs channel was last modified.
    last_modified_date: ?[]const u8 = null,

    /// The type of messaging or notification platform for the channel. For the APNs
    /// channel, this value is APNS.
    platform: []const u8,

    /// The current version of the APNs channel.
    version: ?i32 = null,

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
