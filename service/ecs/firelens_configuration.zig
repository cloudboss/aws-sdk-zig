const aws = @import("aws");

const FirelensConfigurationType = @import("firelens_configuration_type.zig").FirelensConfigurationType;

/// The FireLens configuration for the container. This is used to specify and
/// configure a
/// log router for container logs. For more information, see [Custom log
/// routing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html)
/// in the *Amazon Elastic Container Service Developer Guide*.
pub const FirelensConfiguration = struct {
    /// The options to use when configuring the log router. This field is optional
    /// and can be
    /// used to specify a custom configuration file or to add additional metadata,
    /// such as the
    /// task, task definition, cluster, and container instance details to the log
    /// event. If
    /// specified, the syntax to use is
    /// `"options":{"enable-ecs-log-metadata":"true|false","config-file-type:"s3|file","config-file-value":"arn:aws:s3:::mybucket/fluent.conf|filepath"}`.
    /// For more information, see [Creating
    /// a task definition that uses a FireLens
    /// configuration](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html#firelens-taskdef) in the *Amazon
    /// Elastic Container Service Developer Guide*.
    ///
    /// Tasks hosted on Fargate only support the `file` configuration file
    /// type.
    options: ?[]const aws.map.StringMapEntry,

    /// The log router to use. The valid values are `fluentd` or
    /// `fluentbit`.
    type: FirelensConfigurationType,

    pub const json_field_names = .{
        .options = "options",
        .type = "type",
    };
};
