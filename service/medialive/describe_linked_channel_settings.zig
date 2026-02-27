const DescribeFollowerChannelSettings = @import("describe_follower_channel_settings.zig").DescribeFollowerChannelSettings;
const DescribePrimaryChannelSettings = @import("describe_primary_channel_settings.zig").DescribePrimaryChannelSettings;

/// Linked channel configuration details
pub const DescribeLinkedChannelSettings = struct {
    follower_channel_settings: ?DescribeFollowerChannelSettings,

    primary_channel_settings: ?DescribePrimaryChannelSettings,

    pub const json_field_names = .{
        .follower_channel_settings = "FollowerChannelSettings",
        .primary_channel_settings = "PrimaryChannelSettings",
    };
};
