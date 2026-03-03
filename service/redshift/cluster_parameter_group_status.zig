const ClusterParameterStatus = @import("cluster_parameter_status.zig").ClusterParameterStatus;

/// Describes the status of a parameter group.
pub const ClusterParameterGroupStatus = struct {
    /// The list of parameter statuses.
    ///
    /// For more information about parameters and parameter groups, go to
    /// [Amazon Redshift Parameter
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    cluster_parameter_status_list: ?[]const ClusterParameterStatus = null,

    /// The status of parameter updates.
    parameter_apply_status: ?[]const u8 = null,

    /// The name of the cluster parameter group.
    parameter_group_name: ?[]const u8 = null,
};
