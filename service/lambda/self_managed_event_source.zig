const aws = @import("aws");

/// The self-managed Apache Kafka cluster for your event source.
pub const SelfManagedEventSource = struct {
    /// The list of bootstrap servers for your Kafka brokers in the following
    /// format: `"KAFKA_BOOTSTRAP_SERVERS":
    /// ["abc.xyz.com:xxxx","abc2.xyz.com:xxxx"]`.
    endpoints: ?[]const aws.map.MapEntry([]const []const u8),

    pub const json_field_names = .{
        .endpoints = "Endpoints",
    };
};
