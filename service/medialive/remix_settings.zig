const AudioChannelMapping = @import("audio_channel_mapping.zig").AudioChannelMapping;

/// Remix Settings
pub const RemixSettings = struct {
    /// Mapping of input channels to output channels, with appropriate gain
    /// adjustments.
    channel_mappings: []const AudioChannelMapping,

    /// Number of input channels to be used.
    channels_in: ?i32 = null,

    /// Number of output channels to be produced.
    /// Valid values: 1, 2, 4, 6, 8
    channels_out: ?i32 = null,

    pub const json_field_names = .{
        .channel_mappings = "ChannelMappings",
        .channels_in = "ChannelsIn",
        .channels_out = "ChannelsOut",
    };
};
