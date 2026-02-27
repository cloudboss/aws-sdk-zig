/// Provides information about the general settings and status of a channel for
/// an application.
pub const ChannelResponse = struct {
    /// The unique identifier for the application.
    application_id: ?[]const u8,

    /// The date and time, in ISO 8601 format, when the channel was enabled.
    creation_date: ?[]const u8,

    /// Specifies whether the channel is enabled for the application.
    enabled: ?bool,

    /// (Not used) This property is retained only for backward compatibility.
    has_credential: ?bool,

    /// (Deprecated) An identifier for the channel. This property is retained only
    /// for backward compatibility.
    id: ?[]const u8,

    /// Specifies whether the channel is archived.
    is_archived: ?bool,

    /// The user who last modified the channel.
    last_modified_by: ?[]const u8,

    /// The date and time, in ISO 8601 format, when the channel was last modified.
    last_modified_date: ?[]const u8,

    /// The current version of the channel.
    version: ?i32,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .creation_date = "CreationDate",
        .enabled = "Enabled",
        .has_credential = "HasCredential",
        .id = "Id",
        .is_archived = "IsArchived",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .version = "Version",
    };
};
