pub const S3Permission = enum {
    read,
    write,

    pub const json_field_names = .{
        .read = "READ",
        .write = "WRITE",
    };
};
