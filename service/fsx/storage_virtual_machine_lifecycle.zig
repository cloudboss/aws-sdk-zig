pub const StorageVirtualMachineLifecycle = enum {
    created,
    creating,
    deleting,
    failed,
    misconfigured,
    pending,

    pub const json_field_names = .{
        .created = "CREATED",
        .creating = "CREATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .misconfigured = "MISCONFIGURED",
        .pending = "PENDING",
    };
};
