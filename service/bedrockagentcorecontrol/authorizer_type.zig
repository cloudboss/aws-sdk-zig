pub const AuthorizerType = enum {
    custom_jwt,
    aws_iam,
    none,

    pub const json_field_names = .{
        .custom_jwt = "CUSTOM_JWT",
        .aws_iam = "AWS_IAM",
        .none = "NONE",
    };
};
