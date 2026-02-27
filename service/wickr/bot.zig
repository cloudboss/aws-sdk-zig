const BotStatus = @import("bot_status.zig").BotStatus;

/// Represents a bot account in a Wickr network with all its informational
/// fields.
pub const Bot = struct {
    /// The unique identifier of the bot.
    bot_id: ?[]const u8,

    /// The display name of the bot that is visible to users.
    display_name: ?[]const u8,

    /// The ID of the security group to which the bot belongs.
    group_id: ?[]const u8,

    /// Indicates whether the bot has a password set.
    has_challenge: ?bool,

    /// The timestamp of the bot's last login.
    last_login: ?[]const u8,

    /// The public key of the bot used for encryption.
    pubkey: ?[]const u8,

    /// The current status of the bot (1 for pending, 2 for active).
    status: ?BotStatus,

    /// Indicates whether the bot is currently suspended.
    suspended: ?bool,

    /// The unique username hash identifier for the bot.
    uname: ?[]const u8,

    /// The username of the bot.
    username: ?[]const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .display_name = "displayName",
        .group_id = "groupId",
        .has_challenge = "hasChallenge",
        .last_login = "lastLogin",
        .pubkey = "pubkey",
        .status = "status",
        .suspended = "suspended",
        .uname = "uname",
        .username = "username",
    };
};
