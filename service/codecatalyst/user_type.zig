pub const UserType = enum {
    user,
    aws_account,
    unknown,

    pub const json_field_names = .{
        .user = "USER",
        .aws_account = "AWS_ACCOUNT",
        .unknown = "UNKNOWN",
    };
};
