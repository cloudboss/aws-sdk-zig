pub const ControlOperationType = enum {
    enable_control,
    disable_control,
    update_enabled_control,
    reset_enabled_control,

    pub const json_field_names = .{
        .enable_control = "ENABLE_CONTROL",
        .disable_control = "DISABLE_CONTROL",
        .update_enabled_control = "UPDATE_ENABLED_CONTROL",
        .reset_enabled_control = "RESET_ENABLED_CONTROL",
    };
};
