/// Input Denoise Filter
pub const InputDenoiseFilter = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
