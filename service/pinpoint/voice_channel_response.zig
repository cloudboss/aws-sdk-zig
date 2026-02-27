/// Provides information about the status and settings of the voice channel for
/// an application.
pub const VoiceChannelResponse = struct {
    /// The unique identifier for the application that the voice channel applies to.
    application_id: ?[]const u8,

    /// The date and time, in ISO 8601 format, when the voice channel was enabled.
    creation_date: ?[]const u8,

    /// Specifies whether the voice channel is enabled for the application.
    enabled: ?bool,

    /// (Not used) This property is retained only for backward compatibility.
    has_credential: ?bool,

    /// (Deprecated) An identifier for the voice channel. This property is retained
    /// only for backward compatibility.
    id: ?[]const u8,

    /// Specifies whether the voice channel is archived.
    is_archived: ?bool,

    /// The user who last modified the voice channel.
    last_modified_by: ?[]const u8,

    /// The date and time, in ISO 8601 format, when the voice channel was last
    /// modified.
    last_modified_date: ?[]const u8,

    /// The type of messaging or notification platform for the channel. For the
    /// voice channel, this value is VOICE.
    platform: []const u8,

    /// The current version of the voice channel.
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
        .platform = "Platform",
        .version = "Version",
    };
};
