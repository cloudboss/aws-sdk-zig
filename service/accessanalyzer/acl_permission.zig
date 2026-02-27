pub const AclPermission = enum {
    read,
    write,
    read_acp,
    write_acp,
    full_control,

    pub const json_field_names = .{
        .read = "READ",
        .write = "WRITE",
        .read_acp = "READ_ACP",
        .write_acp = "WRITE_ACP",
        .full_control = "FULL_CONTROL",
    };
};
