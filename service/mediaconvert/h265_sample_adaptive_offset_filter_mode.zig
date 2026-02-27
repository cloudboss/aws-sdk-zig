/// Specify Sample Adaptive Offset (SAO) filter strength. Adaptive mode
/// dynamically selects best strength based on content
pub const H265SampleAdaptiveOffsetFilterMode = enum {
    default,
    adaptive,
    off,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .adaptive = "ADAPTIVE",
        .off = "OFF",
    };
};
