/// Timecode Burnin Font Size
pub const TimecodeBurninFontSize = enum {
    extra_small_10,
    large_48,
    medium_32,
    small_16,

    pub const json_field_names = .{
        .extra_small_10 = "EXTRA_SMALL_10",
        .large_48 = "LARGE_48",
        .medium_32 = "MEDIUM_32",
        .small_16 = "SMALL_16",
    };
};
