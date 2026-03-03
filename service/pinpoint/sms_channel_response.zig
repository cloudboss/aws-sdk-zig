/// Provides information about the status and settings of the SMS channel for an
/// application.
pub const SMSChannelResponse = struct {
    /// The unique identifier for the application that the SMS channel applies to.
    application_id: ?[]const u8 = null,

    /// The date and time, in ISO 8601 format, when the SMS channel was enabled.
    creation_date: ?[]const u8 = null,

    /// Specifies whether the SMS channel is enabled for the application.
    enabled: ?bool = null,

    /// (Not used) This property is retained only for backward compatibility.
    has_credential: ?bool = null,

    /// (Deprecated) An identifier for the SMS channel. This property is retained
    /// only for backward compatibility.
    id: ?[]const u8 = null,

    /// Specifies whether the SMS channel is archived.
    is_archived: ?bool = null,

    /// The user who last modified the SMS channel.
    last_modified_by: ?[]const u8 = null,

    /// The date and time, in ISO 8601 format, when the SMS channel was last
    /// modified.
    last_modified_date: ?[]const u8 = null,

    /// The type of messaging or notification platform for the channel. For the SMS
    /// channel, this value is SMS.
    platform: []const u8,

    /// The maximum number of promotional messages that you can send through the SMS
    /// channel each second.
    promotional_messages_per_second: ?i32 = null,

    /// The identity that displays on recipients' devices when they receive messages
    /// from the SMS channel.
    sender_id: ?[]const u8 = null,

    /// The registered short code to use when you send messages through the SMS
    /// channel.
    short_code: ?[]const u8 = null,

    /// The maximum number of transactional messages that you can send through the
    /// SMS channel each second.
    transactional_messages_per_second: ?i32 = null,

    /// The current version of the SMS channel.
    version: ?i32 = null,

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
        .promotional_messages_per_second = "PromotionalMessagesPerSecond",
        .sender_id = "SenderId",
        .short_code = "ShortCode",
        .transactional_messages_per_second = "TransactionalMessagesPerSecond",
        .version = "Version",
    };
};
