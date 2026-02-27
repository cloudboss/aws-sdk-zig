pub const Action = enum {
    read,
    write,

    pub const json_field_names = .{
        .read = "READ",
        .write = "WRITE",
    };
};
