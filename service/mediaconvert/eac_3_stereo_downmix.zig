/// Choose how the service does stereo downmixing. This setting only applies if
/// you keep the default value of 3/2 - L, R, C, Ls, Rs for the setting Coding
/// mode. If you choose a different value for Coding mode, the service ignores
/// Stereo downmix.
pub const Eac3StereoDownmix = enum {
    not_indicated,
    lo_ro,
    lt_rt,
    dpl2,

    pub const json_field_names = .{
        .not_indicated = "NOT_INDICATED",
        .lo_ro = "LO_RO",
        .lt_rt = "LT_RT",
        .dpl2 = "DPL2",
    };
};
