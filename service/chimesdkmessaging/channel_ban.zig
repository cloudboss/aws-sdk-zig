const Identity = @import("identity.zig").Identity;

/// The details of a channel ban.
pub const ChannelBan = struct {
    /// The ARN of the channel from which a member is being banned.
    channel_arn: ?[]const u8 = null,

    /// The `AppInstanceUser` who created the ban.
    created_by: ?Identity = null,

    /// The time at which the ban was created.
    created_timestamp: ?i64 = null,

    /// The member being banned from the channel.
    member: ?Identity = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .created_by = "CreatedBy",
        .created_timestamp = "CreatedTimestamp",
        .member = "Member",
    };
};
