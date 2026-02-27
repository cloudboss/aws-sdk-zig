pub const Permissions = enum {
    owner,
    read_write,
    read_only,

    pub const json_field_names = .{
        .owner = "OWNER",
        .read_write = "READ_WRITE",
        .read_only = "READ_ONLY",
    };
};
