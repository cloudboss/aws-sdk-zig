pub const S3AccessPointAttachmentLifecycle = enum {
    available,
    creating,
    deleting,
    updating,
    failed,
    misconfigured,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .failed = "FAILED",
        .misconfigured = "MISCONFIGURED",
    };
};
