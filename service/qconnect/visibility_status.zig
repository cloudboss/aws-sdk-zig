pub const VisibilityStatus = enum {
    saved,
    published,

    pub const json_field_names = .{
        .saved = "SAVED",
        .published = "PUBLISHED",
    };
};
