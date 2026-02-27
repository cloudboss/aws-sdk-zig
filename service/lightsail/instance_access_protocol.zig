pub const InstanceAccessProtocol = enum {
    ssh,
    rdp,

    pub const json_field_names = .{
        .ssh = "ssh",
        .rdp = "rdp",
    };
};
