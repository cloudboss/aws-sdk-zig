pub const SnapshotStatus = enum {
    available,
    creating,
    deleted,
    cancelled,
    failed,
    copying,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .deleted = "DELETED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .copying = "COPYING",
    };
};
