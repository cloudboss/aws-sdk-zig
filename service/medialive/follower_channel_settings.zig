const LinkedChannelType = @import("linked_channel_type.zig").LinkedChannelType;

/// Settings for a follower channel in a linked pair
pub const FollowerChannelSettings = struct {
    /// Specifies this as a follower channel
    linked_channel_type: ?LinkedChannelType = null,

    /// The ARN of the primary channel to follow
    primary_channel_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .linked_channel_type = "LinkedChannelType",
        .primary_channel_arn = "PrimaryChannelArn",
    };
};
