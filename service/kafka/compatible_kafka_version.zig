/// Contains source Apache Kafka versions and compatible target Apache Kafka
/// versions.
pub const CompatibleKafkaVersion = struct {
    /// An Apache Kafka version.
    source_version: ?[]const u8,

    /// A list of Apache Kafka versions.
    target_versions: ?[]const []const u8,

    pub const json_field_names = .{
        .source_version = "SourceVersion",
        .target_versions = "TargetVersions",
    };
};
