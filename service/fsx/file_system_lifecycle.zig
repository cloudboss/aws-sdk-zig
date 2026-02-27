/// The lifecycle status of the file system.
pub const FileSystemLifecycle = enum {
    available,
    creating,
    failed,
    deleting,
    misconfigured,
    updating,
    misconfigured_unavailable,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .failed = "FAILED",
        .deleting = "DELETING",
        .misconfigured = "MISCONFIGURED",
        .updating = "UPDATING",
        .misconfigured_unavailable = "MISCONFIGURED_UNAVAILABLE",
    };
};
