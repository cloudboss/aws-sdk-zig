const KafkaSchemaRegistryAuthType = @import("kafka_schema_registry_auth_type.zig").KafkaSchemaRegistryAuthType;

/// Specific access configuration settings that tell Lambda how to authenticate
/// with your schema registry.
///
/// If you're working with an Glue schema registry, don't provide authentication
/// details in this object. Instead, ensure that your execution role has the
/// required permissions for Lambda to access your cluster.
///
/// If you're working with a Confluent schema registry, choose the
/// authentication method in the `Type` field, and provide the Secrets Manager
/// secret ARN in the `URI` field.
pub const KafkaSchemaRegistryAccessConfig = struct {
    /// The type of authentication Lambda uses to access your schema registry.
    type: ?KafkaSchemaRegistryAuthType,

    /// The URI of the secret (Secrets Manager secret ARN) to authenticate with your
    /// schema registry.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .type = "Type",
        .uri = "URI",
    };
};
