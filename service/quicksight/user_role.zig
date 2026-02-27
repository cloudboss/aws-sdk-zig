pub const UserRole = enum {
    admin,
    author,
    reader,
    restricted_author,
    restricted_reader,
    admin_pro,
    author_pro,
    reader_pro,

    pub const json_field_names = .{
        .admin = "ADMIN",
        .author = "AUTHOR",
        .reader = "READER",
        .restricted_author = "RESTRICTED_AUTHOR",
        .restricted_reader = "RESTRICTED_READER",
        .admin_pro = "ADMIN_PRO",
        .author_pro = "AUTHOR_PRO",
        .reader_pro = "READER_PRO",
    };
};
