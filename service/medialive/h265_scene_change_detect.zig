/// H265 Scene Change Detect
pub const H265SceneChangeDetect = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
