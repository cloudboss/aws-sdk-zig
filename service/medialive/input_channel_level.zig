/// Input Channel Level
pub const InputChannelLevel = struct {
    /// Remixing value. Units are in dB and acceptable values are within the range
    /// from -60 (mute) and 6 dB.
    gain: i32,

    /// The index of the input channel used as a source.
    input_channel: i32,

    pub const json_field_names = .{
        .gain = "Gain",
        .input_channel = "InputChannel",
    };
};
