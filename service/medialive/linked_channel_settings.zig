const FollowerChannelSettings = @import("follower_channel_settings.zig").FollowerChannelSettings;
const PrimaryChannelSettings = @import("primary_channel_settings.zig").PrimaryChannelSettings;

/// Configuration for linked channel relationships
pub const LinkedChannelSettings = struct {
    follower_channel_settings: ?FollowerChannelSettings,

    primary_channel_settings: ?PrimaryChannelSettings,

    pub const json_field_names = .{
        .follower_channel_settings = "FollowerChannelSettings",
        .primary_channel_settings = "PrimaryChannelSettings",
    };
};
