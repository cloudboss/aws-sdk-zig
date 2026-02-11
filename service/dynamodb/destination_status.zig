pub const DestinationStatus = enum {
    enabling,
    active,
    disabling,
    disabled,
    enable_failed,
    updating,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .active = "ACTIVE",
        .disabling = "DISABLING",
        .disabled = "DISABLED",
        .enable_failed = "ENABLE_FAILED",
        .updating = "UPDATING",
    };
};
