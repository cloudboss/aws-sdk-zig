pub const SnapshotLifecycle = enum {
    pending,
    creating,
    deleting,
    available,

    pub const json_field_names = .{
        .pending = "PENDING",
        .creating = "CREATING",
        .deleting = "DELETING",
        .available = "AVAILABLE",
    };
};
