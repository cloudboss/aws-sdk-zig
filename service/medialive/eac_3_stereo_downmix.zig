/// Eac3 Stereo Downmix
pub const Eac3StereoDownmix = enum {
    dpl2,
    lo_ro,
    lt_rt,
    not_indicated,

    pub const json_field_names = .{
        .dpl2 = "DPL2",
        .lo_ro = "LO_RO",
        .lt_rt = "LT_RT",
        .not_indicated = "NOT_INDICATED",
    };
};
