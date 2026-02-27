pub const AuthorizationType = enum {
    aws_iam,

    pub const json_field_names = .{
        .aws_iam = "AWS_IAM",
    };
};
