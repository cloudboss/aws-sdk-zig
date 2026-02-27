const InputChannelLevel = @import("input_channel_level.zig").InputChannelLevel;

/// Audio Channel Mapping
pub const AudioChannelMapping = struct {
    /// Indices and gain values for each input channel that should be remixed into
    /// this output channel.
    input_channel_levels: []const InputChannelLevel,

    /// The index of the output channel being produced.
    output_channel: i32,

    pub const json_field_names = .{
        .input_channel_levels = "InputChannelLevels",
        .output_channel = "OutputChannel",
    };
};
