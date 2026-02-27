/// Choose how the service does stereo downmixing. Default value: Not indicated
/// Related setting: To have MediaConvert use this value, keep the default
/// value, Custom for the setting Downmix control. Otherwise, MediaConvert
/// ignores Stereo downmix.
pub const Eac3AtmosStereoDownmix = enum {
    not_indicated,
    stereo,
    surround,
    dpl2,

    pub const json_field_names = .{
        .not_indicated = "NOT_INDICATED",
        .stereo = "STEREO",
        .surround = "SURROUND",
        .dpl2 = "DPL2",
    };
};
