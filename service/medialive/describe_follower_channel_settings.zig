const LinkedChannelType = @import("linked_channel_type.zig").LinkedChannelType;

/// Details of a follower channel in a linked pair
pub const DescribeFollowerChannelSettings = struct {
    /// Specifies this as a follower channel
    linked_channel_type: ?LinkedChannelType = null,

    /// The ARN of the primary channel this channel follows
    primary_channel_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .linked_channel_type = "LinkedChannelType",
        .primary_channel_arn = "PrimaryChannelArn",
    };
};
