const Identity = @import("identity.zig").Identity;

/// The details of a channel moderator.
pub const ChannelModerator = struct {
    /// The ARN of the moderator's channel.
    channel_arn: ?[]const u8 = null,

    /// The `AppInstanceUser` who created the moderator.
    created_by: ?Identity = null,

    /// The time at which the moderator was created.
    created_timestamp: ?i64 = null,

    /// The moderator's data.
    moderator: ?Identity = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .created_by = "CreatedBy",
        .created_timestamp = "CreatedTimestamp",
        .moderator = "Moderator",
    };
};
