pub const EnvironmentType = enum {
    ssh,
    ec2,

    pub const json_field_names = .{
        .ssh = "SSH",
        .ec2 = "EC2",
    };
};
