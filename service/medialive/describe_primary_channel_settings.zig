const LinkedChannelType = @import("linked_channel_type.zig").LinkedChannelType;

/// Details of a primary (leader) channel in a linked pair
pub const DescribePrimaryChannelSettings = struct {
    /// The ARNs of the following channels for this primary channel
    following_channel_arns: ?[]const []const u8,

    /// Specifies this as a primary channel
    linked_channel_type: ?LinkedChannelType,

    pub const json_field_names = .{
        .following_channel_arns = "FollowingChannelArns",
        .linked_channel_type = "LinkedChannelType",
    };
};
