pub const VolumeLifecycle = enum {
    creating,
    created,
    deleting,
    failed,
    misconfigured,
    pending,
    available,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .deleting = "DELETING",
        .failed = "FAILED",
        .misconfigured = "MISCONFIGURED",
        .pending = "PENDING",
        .available = "AVAILABLE",
    };
};
