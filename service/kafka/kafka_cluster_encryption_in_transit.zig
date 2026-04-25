const KafkaClusterEncryptionInTransitType = @import("kafka_cluster_encryption_in_transit_type.zig").KafkaClusterEncryptionInTransitType;

/// Details of encryption in transit to the Apache Kafka cluster.
pub const KafkaClusterEncryptionInTransit = struct {
    /// The type of encryption in transit to the Apache Kafka cluster.
    encryption_type: KafkaClusterEncryptionInTransitType,

    /// The root CA certificate.
    root_ca_certificate: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_type = "EncryptionType",
        .root_ca_certificate = "RootCaCertificate",
    };
};
