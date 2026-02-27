/// Maximum input bitrate in megabits per second. Bitrates up to 50 Mbps are
/// supported currently.
pub const InputMaximumBitrate = enum {
    max_10_mbps,
    max_20_mbps,
    max_50_mbps,

    pub const json_field_names = .{
        .max_10_mbps = "MAX_10_MBPS",
        .max_20_mbps = "MAX_20_MBPS",
        .max_50_mbps = "MAX_50_MBPS",
    };
};
