pub const ContainerMountPointAccessLevel = enum {
    read_only,
    read_and_write,

    pub const json_field_names = .{
        .read_only = "READ_ONLY",
        .read_and_write = "READ_AND_WRITE",
    };
};
