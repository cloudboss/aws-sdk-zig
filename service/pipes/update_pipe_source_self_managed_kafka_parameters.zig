const SelfManagedKafkaAccessConfigurationCredentials = @import("self_managed_kafka_access_configuration_credentials.zig").SelfManagedKafkaAccessConfigurationCredentials;
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
pub const UpdatePipeSourceSelfManagedKafkaParameters = struct {
    /// The maximum number of records to include in each batch.
    batch_size: ?i32 = null,

    /// The credentials needed to access the resource.
    credentials: ?SelfManagedKafkaAccessConfigurationCredentials = null,

    /// The maximum length of a time to wait for events.
    maximum_batching_window_in_seconds: ?i32 = null,

    /// The ARN of the Secrets Manager secret used for certification.
    server_root_ca_certificate: ?[]const u8 = null,

    /// This structure specifies the VPC subnets and security groups for the stream,
    /// and whether a public IP address is to be used.
    vpc: ?SelfManagedKafkaAccessConfigurationVpc = null,

    pub const json_field_names = .{
        .batch_size = "BatchSize",
        .credentials = "Credentials",
        .maximum_batching_window_in_seconds = "MaximumBatchingWindowInSeconds",
        .server_root_ca_certificate = "ServerRootCaCertificate",
        .vpc = "Vpc",
    };
};
