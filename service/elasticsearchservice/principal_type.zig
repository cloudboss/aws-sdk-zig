/// Specifies the type of AWS account permitted to manage VPC endpoints.:
///
/// * AWS_ACCOUNT: Indicates that the account is owned by an AWS user.
///
/// * AWS_SERVICE: Indicates the the account is owned by an AWS service.
pub const PrincipalType = enum {
    aws_account,
    aws_service,

    pub const json_field_names = .{
        .aws_account = "AWS_ACCOUNT",
        .aws_service = "AWS_SERVICE",
    };
};
