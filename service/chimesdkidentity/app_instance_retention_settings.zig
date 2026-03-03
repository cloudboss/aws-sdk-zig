const ChannelRetentionSettings = @import("channel_retention_settings.zig").ChannelRetentionSettings;

/// The details of the data-retention settings for an `AppInstance`.
pub const AppInstanceRetentionSettings = struct {
    /// The length of time in days to retain the messages in a channel.
    channel_retention_settings: ?ChannelRetentionSettings = null,

    pub const json_field_names = .{
        .channel_retention_settings = "ChannelRetentionSettings",
    };
};
