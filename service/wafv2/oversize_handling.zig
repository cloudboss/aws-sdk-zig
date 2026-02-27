pub const OversizeHandling = enum {
    @"continue",
    match,
    no_match,

    pub const json_field_names = .{
        .@"continue" = "CONTINUE",
        .match = "MATCH",
        .no_match = "NO_MATCH",
    };
};
