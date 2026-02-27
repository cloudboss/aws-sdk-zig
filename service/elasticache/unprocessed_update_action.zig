/// Update action that has failed to be processed for the corresponding
/// apply/stop
/// request
pub const UnprocessedUpdateAction = struct {
    /// The ID of the cache cluster
    cache_cluster_id: ?[]const u8,

    /// The error message that describes the reason the request was not processed
    error_message: ?[]const u8,

    /// The error type for requests that are not processed
    error_type: ?[]const u8,

    /// The replication group ID
    replication_group_id: ?[]const u8,

    /// The unique ID of the service update
    service_update_name: ?[]const u8,
};
