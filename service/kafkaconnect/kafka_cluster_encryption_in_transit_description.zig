const KafkaClusterEncryptionInTransitType = @import("kafka_cluster_encryption_in_transit_type.zig").KafkaClusterEncryptionInTransitType;

/// The description of the encryption in transit to the Apache Kafka cluster.
pub const KafkaClusterEncryptionInTransitDescription = struct {
    /// The type of encryption in transit to the Apache Kafka cluster.
    encryption_type: ?KafkaClusterEncryptionInTransitType = null,

    pub const json_field_names = .{
        .encryption_type = "encryptionType",
    };
};
