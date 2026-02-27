pub const ParsingStrategy = enum {
    bedrock_foundation_model,
    bedrock_data_automation,

    pub const json_field_names = .{
        .bedrock_foundation_model = "BEDROCK_FOUNDATION_MODEL",
        .bedrock_data_automation = "BEDROCK_DATA_AUTOMATION",
    };
};
