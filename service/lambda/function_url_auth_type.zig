pub const FunctionUrlAuthType = enum {
    none,
    aws_iam,

    pub const json_field_names = .{
        .none = "NONE",
        .aws_iam = "AWS_IAM",
    };
};
