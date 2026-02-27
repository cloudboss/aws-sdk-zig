const ChannelDefinition = @import("channel_definition.zig").ChannelDefinition;

/// Defines a streaming channel.
pub const StreamChannelDefinition = struct {
    /// The definitions of the channels in a streaming channel.
    channel_definitions: ?[]const ChannelDefinition,

    /// The number of channels in a streaming channel.
    number_of_channels: i32,

    pub const json_field_names = .{
        .channel_definitions = "ChannelDefinitions",
        .number_of_channels = "NumberOfChannels",
    };
};
