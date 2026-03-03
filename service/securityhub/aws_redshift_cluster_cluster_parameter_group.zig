const AwsRedshiftClusterClusterParameterStatus = @import("aws_redshift_cluster_cluster_parameter_status.zig").AwsRedshiftClusterClusterParameterStatus;

/// A cluster parameter group that is associated with an Amazon Redshift
/// cluster.
pub const AwsRedshiftClusterClusterParameterGroup = struct {
    /// The list of parameter statuses.
    cluster_parameter_status_list: ?[]const AwsRedshiftClusterClusterParameterStatus = null,

    /// The status of updates to the parameters.
    parameter_apply_status: ?[]const u8 = null,

    /// The name of the parameter group.
    parameter_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_parameter_status_list = "ClusterParameterStatusList",
        .parameter_apply_status = "ParameterApplyStatus",
        .parameter_group_name = "ParameterGroupName",
    };
};
