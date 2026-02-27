pub const ParsingStrategy = enum {
    bedrock_foundation_model,

    pub const json_field_names = .{
        .bedrock_foundation_model = "BEDROCK_FOUNDATION_MODEL",
    };
};
