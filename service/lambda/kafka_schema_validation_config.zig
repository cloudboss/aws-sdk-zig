const KafkaSchemaValidationAttribute = @import("kafka_schema_validation_attribute.zig").KafkaSchemaValidationAttribute;

/// Specific schema validation configuration settings that tell Lambda the
/// message attributes you want to validate and filter using your schema
/// registry.
pub const KafkaSchemaValidationConfig = struct {
    /// The attributes you want your schema registry to validate and filter for. If
    /// you selected `JSON` as the `EventRecordFormat`, Lambda also deserializes the
    /// selected message attributes.
    attribute: ?KafkaSchemaValidationAttribute = null,

    pub const json_field_names = .{
        .attribute = "Attribute",
    };
};
