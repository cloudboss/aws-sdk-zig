pub const KafkaSchemaValidationAttribute = enum {
    key,
    value,

    pub const json_field_names = .{
        .key = "KEY",
        .value = "VALUE",
    };
};
