const ConfigurationRevision = @import("configuration_revision.zig").ConfigurationRevision;
const ConfigurationState = @import("configuration_state.zig").ConfigurationState;

/// Represents an MSK Configuration.
pub const Configuration = struct {
    /// The Amazon Resource Name (ARN) of the configuration.
    arn: []const u8,

    /// The time when the configuration was created.
    creation_time: i64,

    /// The description of the configuration.
    description: []const u8,

    /// An array of the versions of Apache Kafka with which you can use this MSK
    /// configuration. You can use this configuration for an MSK cluster only if the
    /// Apache Kafka version specified for the cluster appears in this array.
    kafka_versions: []const []const u8,

    /// Latest revision of the configuration.
    latest_revision: ConfigurationRevision,

    /// The name of the configuration.
    name: []const u8,

    /// The state of the configuration. The possible states are ACTIVE, DELETING,
    /// and DELETE_FAILED.
    state: ConfigurationState,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .description = "Description",
        .kafka_versions = "KafkaVersions",
        .latest_revision = "LatestRevision",
        .name = "Name",
        .state = "State",
    };
};
