const aws = @import("aws");

/// The FireLens configuration for the container. The configuration specifies
/// and configures a log router for container logs.
pub const AwsEcsTaskDefinitionContainerDefinitionsFirelensConfigurationDetails = struct {
    /// The options to use to configure the log router.
    ///
    /// The valid option keys are as follows:
    ///
    /// * `enable-ecs-log-metadata`. The value can be `true` or
    /// `false`.
    ///
    /// * `config-file-type`. The value can be `s3` or
    /// `file`.
    ///
    /// * `config-file-value`. The value is either an S3 ARN or a file path.
    options: ?[]const aws.map.StringMapEntry,

    /// The log router to use. Valid values are `fluentbit` or `fluentd`.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .options = "Options",
        .@"type" = "Type",
    };
};
