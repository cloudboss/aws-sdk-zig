const AwsEcsClusterConfigurationExecuteCommandConfigurationDetails = @import("aws_ecs_cluster_configuration_execute_command_configuration_details.zig").AwsEcsClusterConfigurationExecuteCommandConfigurationDetails;

/// The run command configuration for the cluster.
pub const AwsEcsClusterConfigurationDetails = struct {
    /// Contains the run command configuration for the cluster.
    execute_command_configuration: ?AwsEcsClusterConfigurationExecuteCommandConfigurationDetails = null,

    pub const json_field_names = .{
        .execute_command_configuration = "ExecuteCommandConfiguration",
    };
};
