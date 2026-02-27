pub const DeviceCgroupPermission = enum {
    read,
    write,
    mknod,

    pub const json_field_names = .{
        .read = "READ",
        .write = "WRITE",
        .mknod = "MKNOD",
    };
};
