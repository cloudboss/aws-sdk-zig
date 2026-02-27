/// Av1 Scene Change Detect
pub const Av1SceneChangeDetect = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
