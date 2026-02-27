pub const InterpretationSource = enum {
    bedrock,
    lex,

    pub const json_field_names = .{
        .bedrock = "BEDROCK",
        .lex = "LEX",
    };
};
