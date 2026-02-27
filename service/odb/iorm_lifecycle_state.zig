pub const IormLifecycleState = enum {
    bootstrapping,
    disabled,
    enabled,
    failed,
    updating,

    pub const json_field_names = .{
        .bootstrapping = "BOOTSTRAPPING",
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .failed = "FAILED",
        .updating = "UPDATING",
    };
};
