pub const Permission = enum {
    full_control,
    write,
    write_acp,
    read,
    read_acp,

    pub const json_field_names = .{
        .full_control = "FULL_CONTROL",
        .write = "WRITE",
        .write_acp = "WRITE_ACP",
        .read = "READ",
        .read_acp = "READ_ACP",
    };
};
