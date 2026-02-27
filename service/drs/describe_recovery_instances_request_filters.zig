/// A set of filters by which to return Recovery Instances.
pub const DescribeRecoveryInstancesRequestFilters = struct {
    /// An array of Recovery Instance IDs that should be returned. An empty array
    /// means all Recovery Instances.
    recovery_instance_i_ds: ?[]const []const u8,

    /// An array of Source Server IDs for which associated Recovery Instances should
    /// be returned.
    source_server_i_ds: ?[]const []const u8,

    pub const json_field_names = .{
        .recovery_instance_i_ds = "recoveryInstanceIDs",
        .source_server_i_ds = "sourceServerIDs",
    };
};
