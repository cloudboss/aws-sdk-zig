/// Aac Profile
pub const AacProfile = enum {
    hev1,
    hev2,
    lc,

    pub const json_field_names = .{
        .hev1 = "HEV1",
        .hev2 = "HEV2",
        .lc = "LC",
    };
};
