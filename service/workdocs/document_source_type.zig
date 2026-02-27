pub const DocumentSourceType = enum {
    original,
    with_comments,

    pub const json_field_names = .{
        .original = "ORIGINAL",
        .with_comments = "WITH_COMMENTS",
    };
};
