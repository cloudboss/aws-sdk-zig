/// An insight describing a usage pattern and the signals detected.
pub const Insight = struct {
    /// A description of the signals detected.
    signals_detected: ?[]const u8 = null,

    /// A description of the usage pattern.
    usage_pattern: []const u8,

    pub const json_field_names = .{
        .signals_detected = "signalsDetected",
        .usage_pattern = "usagePattern",
    };
};
