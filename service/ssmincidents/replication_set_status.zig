pub const ReplicationSetStatus = enum {
    /// All operations have completed successfully and the replication set is ready
    /// to use
    active,
    /// Replication set is in the process of being created.
    creating,
    /// Replication set is in the process of being updated.
    updating,
    /// Replication set is in the process of being deleted.
    deleting,
    /// Replication set is not healthy and we cannot fix it.
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .failed = "FAILED",
    };
};
