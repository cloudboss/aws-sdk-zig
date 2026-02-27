pub const ProvisionTargetType = enum {
    aws_account,
    all_provisioned_accounts,

    pub const json_field_names = .{
        .aws_account = "AWS_ACCOUNT",
        .all_provisioned_accounts = "ALL_PROVISIONED_ACCOUNTS",
    };
};
