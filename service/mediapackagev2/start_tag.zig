/// To insert an EXT-X-START tag in your HLS playlist, specify a StartTag
/// configuration object with a valid TimeOffset. When you do, you can also
/// optionally specify whether to include a PRECISE value in the EXT-X-START
/// tag.
pub const StartTag = struct {
    /// Specify the value for PRECISE within your EXT-X-START tag. Leave blank, or
    /// choose false, to use the default value NO. Choose yes to use the value YES.
    precise: ?bool = null,

    /// Specify the value for TIME-OFFSET within your EXT-X-START tag. Enter a
    /// signed floating point value which, if positive, must be less than the
    /// configured manifest duration minus three times the configured segment target
    /// duration. If negative, the absolute value must be larger than three times
    /// the configured segment target duration, and the absolute value must be
    /// smaller than the configured manifest duration.
    time_offset: f32,

    pub const json_field_names = .{
        .precise = "Precise",
        .time_offset = "TimeOffset",
    };
};
