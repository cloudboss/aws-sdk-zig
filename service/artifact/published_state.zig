pub const PublishedState = enum {
    published,
    unpublished,

    pub const json_field_names = .{
        .published = "PUBLISHED",
        .unpublished = "UNPUBLISHED",
    };
};
