pub const ConnectionType = enum {
    connect_ssh,
    connect_ssm,

    pub const json_field_names = .{
        .connect_ssh = "CONNECT_SSH",
        .connect_ssm = "CONNECT_SSM",
    };
};
