pub const MatchPurpose = enum {
    identifier_generation,
    indexing,

    pub const json_field_names = .{
        .identifier_generation = "IDENTIFIER_GENERATION",
        .indexing = "INDEXING",
    };
};
