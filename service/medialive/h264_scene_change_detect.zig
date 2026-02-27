/// H264 Scene Change Detect
pub const H264SceneChangeDetect = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
