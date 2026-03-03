/// Information about the current software installed on the cluster.
pub const BrokerSoftwareInfo = struct {
    /// The Amazon Resource Name (ARN) of the configuration used for the cluster.
    /// This field isn't visible in this preview release.
    configuration_arn: ?[]const u8 = null,

    /// The revision of the configuration to use. This field isn't visible in this
    /// preview release.
    configuration_revision: ?i64 = null,

    /// The version of Apache Kafka.
    kafka_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_arn = "ConfigurationArn",
        .configuration_revision = "ConfigurationRevision",
        .kafka_version = "KafkaVersion",
    };
};
