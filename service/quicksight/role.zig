pub const Role = enum {
    admin,
    author,
    reader,
    admin_pro,
    author_pro,
    reader_pro,

    pub const json_field_names = .{
        .admin = "ADMIN",
        .author = "AUTHOR",
        .reader = "READER",
        .admin_pro = "ADMIN_PRO",
        .author_pro = "AUTHOR_PRO",
        .reader_pro = "READER_PRO",
    };
};
