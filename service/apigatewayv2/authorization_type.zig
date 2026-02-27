/// The authorization type. For WebSocket APIs, valid values are NONE for open
/// access, AWS_IAM for using AWS IAM permissions, and CUSTOM for using a Lambda
/// authorizer. For HTTP APIs, valid values are NONE for open access, JWT for
/// using JSON Web Tokens, AWS_IAM for using AWS IAM permissions, and CUSTOM for
/// using a Lambda authorizer.
pub const AuthorizationType = enum {
    none,
    aws_iam,
    custom,
    jwt,

    pub const json_field_names = .{
        .none = "NONE",
        .aws_iam = "AWS_IAM",
        .custom = "CUSTOM",
        .jwt = "JWT",
    };
};
