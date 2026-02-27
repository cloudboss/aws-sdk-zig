/// Aac Input Type
pub const AacInputType = enum {
    broadcaster_mixed_ad,
    normal,

    pub const json_field_names = .{
        .broadcaster_mixed_ad = "BROADCASTER_MIXED_AD",
        .normal = "NORMAL",
    };
};
