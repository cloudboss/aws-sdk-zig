pub const Service = enum {
    ec2,
    ecr,
    lambda,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .ecr = "ECR",
        .lambda = "LAMBDA",
    };
};
