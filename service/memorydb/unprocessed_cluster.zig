/// A cluster whose updates have failed
pub const UnprocessedCluster = struct {
    /// The name of the cluster
    cluster_name: ?[]const u8 = null,

    /// The error message associated with the update failure
    error_message: ?[]const u8 = null,

    /// The error type associated with the update failure
    error_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .error_message = "ErrorMessage",
        .error_type = "ErrorType",
    };
};
