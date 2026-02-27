/// Used in DescribeNetworkResult, DescribeNetworkSummary, UpdateNetworkResult.
pub const NetworkState = enum {
    creating,
    create_failed,
    active,
    deleting,
    idle,
    in_use,
    updating,
    delete_failed,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .idle = "IDLE",
        .in_use = "IN_USE",
        .updating = "UPDATING",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
    };
};
