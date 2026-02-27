pub const StandbyReplicas = enum {
    /// Standby replicas enabled
    enabled,
    /// Standby replicas disabled
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
