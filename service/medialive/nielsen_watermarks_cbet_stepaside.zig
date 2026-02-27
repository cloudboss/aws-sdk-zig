/// Nielsen Watermarks Cbet Stepaside
pub const NielsenWatermarksCbetStepaside = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
