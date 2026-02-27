pub const ViewStatus = enum {
    published,
    saved,

    pub const json_field_names = .{
        .published = "PUBLISHED",
        .saved = "SAVED",
    };
};
