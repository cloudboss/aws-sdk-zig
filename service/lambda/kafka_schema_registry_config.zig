const KafkaSchemaRegistryAccessConfig = @import("kafka_schema_registry_access_config.zig").KafkaSchemaRegistryAccessConfig;
const SchemaRegistryEventRecordFormat = @import("schema_registry_event_record_format.zig").SchemaRegistryEventRecordFormat;
const KafkaSchemaValidationConfig = @import("kafka_schema_validation_config.zig").KafkaSchemaValidationConfig;

/// Specific configuration settings for a Kafka schema registry.
pub const KafkaSchemaRegistryConfig = struct {
    /// An array of access configuration objects that tell Lambda how to
    /// authenticate with your schema registry.
    access_configs: ?[]const KafkaSchemaRegistryAccessConfig,

    /// The record format that Lambda delivers to your function after schema
    /// validation.
    ///
    /// * Choose `JSON` to have Lambda deliver the record to your function as a
    ///   standard JSON object.
    /// * Choose `SOURCE` to have Lambda deliver the record to your function in its
    ///   original source format. Lambda removes all schema metadata, such as the
    ///   schema ID, before sending the record to your function.
    event_record_format: ?SchemaRegistryEventRecordFormat,

    /// The URI for your schema registry. The correct URI format depends on the type
    /// of schema registry you're using.
    ///
    /// * For Glue schema registries, use the ARN of the registry.
    /// * For Confluent schema registries, use the URL of the registry.
    schema_registry_uri: ?[]const u8,

    /// An array of schema validation configuration objects, which tell Lambda the
    /// message attributes you want to validate and filter using your schema
    /// registry.
    schema_validation_configs: ?[]const KafkaSchemaValidationConfig,
};
