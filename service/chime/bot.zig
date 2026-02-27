const BotType = @import("bot_type.zig").BotType;

/// A resource that allows Enterprise account administrators to configure an
/// interface to receive events from Amazon Chime.
pub const Bot = struct {
    /// The bot email address.
    bot_email: ?[]const u8,

    /// The bot ID.
    bot_id: ?[]const u8,

    /// The bot type.
    bot_type: ?BotType,

    /// The bot creation timestamp, in ISO 8601 format.
    created_timestamp: ?i64,

    /// When true, the bot is stopped from running in your account.
    disabled: ?bool,

    /// The bot display name.
    display_name: ?[]const u8,

    /// The security token used to authenticate Amazon Chime with the outgoing event
    /// endpoint.
    security_token: ?[]const u8,

    /// The updated bot timestamp, in ISO 8601 format.
    updated_timestamp: ?i64,

    /// The unique ID for the bot user.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .bot_email = "BotEmail",
        .bot_id = "BotId",
        .bot_type = "BotType",
        .created_timestamp = "CreatedTimestamp",
        .disabled = "Disabled",
        .display_name = "DisplayName",
        .security_token = "SecurityToken",
        .updated_timestamp = "UpdatedTimestamp",
        .user_id = "UserId",
    };
};
