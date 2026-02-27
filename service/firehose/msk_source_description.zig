const AuthenticationConfiguration = @import("authentication_configuration.zig").AuthenticationConfiguration;

/// Details about the Amazon MSK cluster used as the source for a Firehose
/// stream.
pub const MSKSourceDescription = struct {
    /// The authentication configuration of the Amazon MSK cluster.
    authentication_configuration: ?AuthenticationConfiguration,

    /// Firehose starts retrieving records from the topic within the Amazon MSK
    /// cluster starting with this timestamp.
    delivery_start_timestamp: ?i64,

    /// The ARN of the Amazon MSK cluster.
    msk_cluster_arn: ?[]const u8,

    /// The start date and time in UTC for the offset position within your MSK topic
    /// from where
    /// Firehose begins to read. By default, this is set to timestamp when Firehose
    /// becomes Active.
    ///
    /// If you want to create a Firehose stream with Earliest start position from
    /// SDK or CLI,
    /// you need to set the `ReadFromTimestampUTC` parameter to Epoch
    /// (1970-01-01T00:00:00Z).
    read_from_timestamp: ?i64,

    /// The topic name within the Amazon MSK cluster.
    topic_name: ?[]const u8,

    pub const json_field_names = .{
        .authentication_configuration = "AuthenticationConfiguration",
        .delivery_start_timestamp = "DeliveryStartTimestamp",
        .msk_cluster_arn = "MSKClusterARN",
        .read_from_timestamp = "ReadFromTimestamp",
        .topic_name = "TopicName",
    };
};
