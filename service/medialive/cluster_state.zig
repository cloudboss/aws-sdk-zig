/// Used in DescribeClusterSummary, DescribeClusterResult, UpdateClusterResult.
pub const ClusterState = enum {
    creating,
    create_failed,
    active,
    deleting,
    delete_failed,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
    };
};
