pub const ConfigRuleComplianceSummaryGroupKey = enum {
    account_id,
    aws_region,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .aws_region = "AWS_REGION",
    };
};
