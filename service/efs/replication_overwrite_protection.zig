pub const ReplicationOverwriteProtection = enum {
    enabled,
    disabled,
    replicating,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .replicating = "REPLICATING",
    };
};
