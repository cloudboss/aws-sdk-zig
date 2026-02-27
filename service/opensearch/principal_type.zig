pub const PrincipalType = enum {
    aws_account,
    aws_service,

    pub const json_field_names = .{
        .aws_account = "AWS_ACCOUNT",
        .aws_service = "AWS_SERVICE",
    };
};
