/// OutputChannel mapping settings.
pub const OutputChannelMapping = struct {
    /// Use this setting to specify your remix values when they are integers, such
    /// as -10, 0, or 4.
    input_channels: ?[]const i32,

    /// Use this setting to specify your remix values when they have a decimal
    /// component, such as -10.312, 0.08, or 4.9. MediaConvert rounds your remixing
    /// values to the nearest thousandth.
    input_channels_fine_tune: ?[]const f64,

    pub const json_field_names = .{
        .input_channels = "InputChannels",
        .input_channels_fine_tune = "InputChannelsFineTune",
    };
};
