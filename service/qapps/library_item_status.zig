pub const LibraryItemStatus = enum {
    published,
    disabled,

    pub const json_field_names = .{
        .published = "PUBLISHED",
        .disabled = "DISABLED",
    };
};
