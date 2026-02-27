/// Provides information about the status and settings of the Baidu (Baidu Cloud
/// Push) channel for an application.
pub const BaiduChannelResponse = struct {
    /// The unique identifier for the application that the Baidu channel applies to.
    application_id: ?[]const u8,

    /// The date and time when the Baidu channel was enabled.
    creation_date: ?[]const u8,

    /// The API key that you received from the Baidu Cloud Push service to
    /// communicate with the service.
    credential: []const u8,

    /// Specifies whether the Baidu channel is enabled for the application.
    enabled: ?bool,

    /// (Not used) This property is retained only for backward compatibility.
    has_credential: ?bool,

    /// (Deprecated) An identifier for the Baidu channel. This property is retained
    /// only for backward compatibility.
    id: ?[]const u8,

    /// Specifies whether the Baidu channel is archived.
    is_archived: ?bool,

    /// The user who last modified the Baidu channel.
    last_modified_by: ?[]const u8,

    /// The date and time when the Baidu channel was last modified.
    last_modified_date: ?[]const u8,

    /// The type of messaging or notification platform for the channel. For the
    /// Baidu channel, this value is BAIDU.
    platform: []const u8,

    /// The current version of the Baidu channel.
    version: ?i32,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .creation_date = "CreationDate",
        .credential = "Credential",
        .enabled = "Enabled",
        .has_credential = "HasCredential",
        .id = "Id",
        .is_archived = "IsArchived",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .platform = "Platform",
        .version = "Version",
    };
};
