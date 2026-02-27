pub const ComputePlatform = enum {
    /// Compute platform meant to used for all usecases (like EC2, Fargate, physical
    /// servers etc.) but AWS Lambda.
    default,
    /// Compute platform meant to used for AWS Lambda.
    awslambda,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .awslambda = "AWSLAMBDA",
    };
};
