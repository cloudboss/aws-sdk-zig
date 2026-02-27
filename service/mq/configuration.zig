const aws = @import("aws");

const AuthenticationStrategy = @import("authentication_strategy.zig").AuthenticationStrategy;
const EngineType = @import("engine_type.zig").EngineType;
const ConfigurationRevision = @import("configuration_revision.zig").ConfigurationRevision;

/// Returns information about all configurations.
pub const Configuration = struct {
    /// Required. The ARN of the configuration.
    arn: []const u8,

    /// Optional. The authentication strategy associated with the configuration. The
    /// default is SIMPLE.
    authentication_strategy: AuthenticationStrategy,

    /// Required. The date and time of the configuration revision.
    created: i64,

    /// Required. The description of the configuration.
    description: []const u8,

    /// Required. The type of broker engine. Currently, Amazon MQ supports ACTIVEMQ
    /// and RABBITMQ.
    engine_type: EngineType,

    /// The broker engine version. Defaults to the latest available version for the
    /// specified broker engine type. For a list of supported engine versions, see
    /// the [ActiveMQ version
    /// management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/activemq-version-management.html) and the [RabbitMQ version management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/rabbitmq-version-management.html) sections in the Amazon MQ Developer Guide.
    engine_version: []const u8,

    /// Required. The unique ID that Amazon MQ generates for the configuration.
    id: []const u8,

    /// Required. The latest revision of the configuration.
    latest_revision: ConfigurationRevision,

    /// Required. The name of the configuration. This value can contain only
    /// alphanumeric characters, dashes, periods, underscores, and tildes (- . _ ~).
    /// This value must be 1-150 characters long.
    name: []const u8,

    /// The list of all tags associated with this configuration.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .authentication_strategy = "AuthenticationStrategy",
        .created = "Created",
        .description = "Description",
        .engine_type = "EngineType",
        .engine_version = "EngineVersion",
        .id = "Id",
        .latest_revision = "LatestRevision",
        .name = "Name",
        .tags = "Tags",
    };
};
