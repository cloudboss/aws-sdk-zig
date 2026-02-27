pub const PublicAccessStatus = enum {
    blocked,
    allowed,

    pub const json_field_names = .{
        .blocked = "BLOCKED",
        .allowed = "ALLOWED",
    };
};
