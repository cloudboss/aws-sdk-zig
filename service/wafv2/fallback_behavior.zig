pub const FallbackBehavior = enum {
    match,
    no_match,

    pub const json_field_names = .{
        .match = "MATCH",
        .no_match = "NO_MATCH",
    };
};
