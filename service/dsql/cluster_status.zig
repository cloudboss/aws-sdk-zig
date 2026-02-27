/// The current status of a cluster.
pub const ClusterStatus = enum {
    creating,
    active,
    idle,
    inactive,
    updating,
    deleting,
    deleted,
    failed,
    pending_setup,
    pending_delete,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .idle = "IDLE",
        .inactive = "INACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .pending_setup = "PENDING_SETUP",
        .pending_delete = "PENDING_DELETE",
    };
};
