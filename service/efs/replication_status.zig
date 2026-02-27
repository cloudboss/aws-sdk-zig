pub const ReplicationStatus = enum {
    enabled,
    enabling,
    deleting,
    @"error",
    paused,
    pausing,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .enabling = "ENABLING",
        .deleting = "DELETING",
        .@"error" = "ERROR",
        .paused = "PAUSED",
        .pausing = "PAUSING",
    };
};
