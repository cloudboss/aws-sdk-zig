/// Returns the status of the CacheCluster.
pub const CacheClusterStatus = enum {
    create_in_progress,
    available,
    delete_in_progress,
    not_available,
    flush_in_progress,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .available = "AVAILABLE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .not_available = "NOT_AVAILABLE",
        .flush_in_progress = "FLUSH_IN_PROGRESS",
    };
};
