/// Whether the action requires user confirmation.
pub const RequireConfirmation = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
