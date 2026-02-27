pub const DevEnvironmentSessionType = enum {
    ssm,
    ssh,

    pub const json_field_names = .{
        .ssm = "SSM",
        .ssh = "SSH",
    };
};
