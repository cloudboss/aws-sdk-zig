const aws = @import("aws");

const AwsEcsTaskDefinitionContainerDefinitionsLogConfigurationSecretOptionsDetails = @import("aws_ecs_task_definition_container_definitions_log_configuration_secret_options_details.zig").AwsEcsTaskDefinitionContainerDefinitionsLogConfigurationSecretOptionsDetails;

/// The log configuration specification for the container.
pub const AwsEcsTaskDefinitionContainerDefinitionsLogConfigurationDetails = struct {
    /// The log driver to use for the container.
    ///
    /// Valid values on Fargate are as follows:
    ///
    /// * `awsfirelens`
    ///
    /// * `awslogs`
    ///
    /// * `splunk`
    ///
    /// Valid values on Amazon EC2 are as follows:
    ///
    /// * `awsfirelens`
    ///
    /// * `awslogs`
    ///
    /// * `fluentd`
    ///
    /// * `gelf`
    ///
    /// * `journald`
    ///
    /// * `json-file`
    ///
    /// * `logentries`
    ///
    /// * `splunk`
    ///
    /// * `syslog`
    log_driver: ?[]const u8 = null,

    /// The configuration options to send to the log driver. Requires version 1.19
    /// of the Docker Remote API or greater on your container instance.
    options: ?[]const aws.map.StringMapEntry = null,

    /// The secrets to pass to the log configuration.
    secret_options: ?[]const AwsEcsTaskDefinitionContainerDefinitionsLogConfigurationSecretOptionsDetails = null,

    pub const json_field_names = .{
        .log_driver = "LogDriver",
        .options = "Options",
        .secret_options = "SecretOptions",
    };
};
