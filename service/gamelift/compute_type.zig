pub const ComputeType = enum {
    ec2,
    anywhere,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .anywhere = "ANYWHERE",
    };
};
