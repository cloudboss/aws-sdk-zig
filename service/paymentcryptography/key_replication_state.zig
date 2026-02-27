/// Defines the replication state of a key
pub const KeyReplicationState = enum {
    in_progress,
    delete_in_progress,
    failed,
    synchronized,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .failed = "FAILED",
        .synchronized = "SYNCHRONIZED",
    };
};
