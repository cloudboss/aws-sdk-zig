/// The source to activate (use) from the input device.
pub const InputDeviceConfiguredInput = enum {
    auto,
    hdmi,
    sdi,

    pub const json_field_names = .{
        .auto = "AUTO",
        .hdmi = "HDMI",
        .sdi = "SDI",
    };
};
