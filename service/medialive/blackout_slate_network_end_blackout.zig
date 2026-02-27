/// Blackout Slate Network End Blackout
pub const BlackoutSlateNetworkEndBlackout = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
