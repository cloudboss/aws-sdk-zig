pub const ReadWriteType = enum {
    read_only,
    write_only,
    all,

    pub const json_field_names = .{
        .read_only = "ReadOnly",
        .write_only = "WriteOnly",
        .all = "All",
    };
};
