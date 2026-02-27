pub const BodyParsingFallbackBehavior = enum {
    match,
    no_match,
    evaluate_as_string,

    pub const json_field_names = .{
        .match = "MATCH",
        .no_match = "NO_MATCH",
        .evaluate_as_string = "EVALUATE_AS_STRING",
    };
};
