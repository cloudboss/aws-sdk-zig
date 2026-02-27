/// The source at the input device that is currently active.
pub const InputDeviceActiveInput = enum {
    hdmi,
    sdi,

    pub const json_field_names = .{
        .hdmi = "HDMI",
        .sdi = "SDI",
    };
};
