pub const UpdateType = enum {
    os,
    network,
    size,

    pub const json_field_names = .{
        .os = "OS",
        .network = "NETWORK",
        .size = "SIZE",
    };
};
