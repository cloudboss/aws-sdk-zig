const AwsEcsClusterConfigurationExecuteCommandConfigurationLogConfigurationDetails = @import("aws_ecs_cluster_configuration_execute_command_configuration_log_configuration_details.zig").AwsEcsClusterConfigurationExecuteCommandConfigurationLogConfigurationDetails;

/// Contains the run command configuration for the cluster.
pub const AwsEcsClusterConfigurationExecuteCommandConfigurationDetails = struct {
    /// The identifier of the KMS key that is used to encrypt the data between the
    /// local client and the container.
    kms_key_id: ?[]const u8 = null,

    /// The log configuration for the results of the run command actions. Required
    /// if `Logging` is `NONE`.
    log_configuration: ?AwsEcsClusterConfigurationExecuteCommandConfigurationLogConfigurationDetails = null,

    /// The log setting to use for redirecting logs for run command results.
    logging: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .log_configuration = "LogConfiguration",
        .logging = "Logging",
    };
};
