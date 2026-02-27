pub const SyncJobState = enum {
    creating,
    initializing,
    active,
    deleting,
    @"error",

    pub const json_field_names = .{
        .creating = "CREATING",
        .initializing = "INITIALIZING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .@"error" = "ERROR",
    };
};
