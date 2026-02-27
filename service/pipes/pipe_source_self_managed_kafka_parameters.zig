const SelfManagedKafkaAccessConfigurationCredentials = @import("self_managed_kafka_access_configuration_credentials.zig").SelfManagedKafkaAccessConfigurationCredentials;
const SelfManagedKafkaStartPosition = @import("self_managed_kafka_start_position.zig").SelfManagedKafkaStartPosition;
const SelfManagedKafkaAccessConfigurationVpc = @import("self_managed_kafka_access_configuration_vpc.zig").SelfManagedKafkaAccessConfigurationVpc;

/// The parameters for using a self-managed Apache Kafka stream as a source.
///
/// A *self managed* cluster refers to any Apache Kafka cluster not hosted by
/// Amazon Web Services.
/// This includes both clusters you manage yourself, as well as those hosted by
/// a third-party
/// provider, such as [Confluent
/// Cloud](https://www.confluent.io/),
/// [CloudKarafka](https://www.cloudkarafka.com/), or
/// [Redpanda](https://redpanda.com/). For more information, see [Apache Kafka
/// streams as a
/// source](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes-kafka.html) in the *Amazon EventBridge User Guide*.
pub const PipeSourceSelfManagedKafkaParameters = struct {
    /// An array of server URLs.
    additional_bootstrap_servers: ?[]const []const u8,

    /// The maximum number of records to include in each batch.
    batch_size: ?i32,

    /// The name of the destination queue to consume.
    consumer_group_id: ?[]const u8,

    /// The credentials needed to access the resource.
    credentials: ?SelfManagedKafkaAccessConfigurationCredentials,

    /// The maximum length of a time to wait for events.
    maximum_batching_window_in_seconds: ?i32,

    /// The ARN of the Secrets Manager secret used for certification.
    server_root_ca_certificate: ?[]const u8,

    /// The position in a stream from which to start reading.
    starting_position: ?SelfManagedKafkaStartPosition,

    /// The name of the topic that the pipe will read from.
    topic_name: []const u8,

    /// This structure specifies the VPC subnets and security groups for the stream,
    /// and whether a public IP address is to be used.
    vpc: ?SelfManagedKafkaAccessConfigurationVpc,

    pub const json_field_names = .{
        .additional_bootstrap_servers = "AdditionalBootstrapServers",
        .batch_size = "BatchSize",
        .consumer_group_id = "ConsumerGroupID",
        .credentials = "Credentials",
        .maximum_batching_window_in_seconds = "MaximumBatchingWindowInSeconds",
        .server_root_ca_certificate = "ServerRootCaCertificate",
        .starting_position = "StartingPosition",
        .topic_name = "TopicName",
        .vpc = "Vpc",
    };
};
