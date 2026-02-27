pub const MemberPermissions = enum {
    read_write,
    read_only,

    pub const json_field_names = .{
        .read_write = "READ_WRITE",
        .read_only = "READ_ONLY",
    };
};
