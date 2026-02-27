pub const AwsMemberBusinessTitle = enum {
    aws_sales_rep,
    aws_account_owner,
    wwpspdm,
    pdm,
    psm,
    isvsm,

    pub const json_field_names = .{
        .aws_sales_rep = "AWS_SALES_REP",
        .aws_account_owner = "AWS_ACCOUNT_OWNER",
        .wwpspdm = "WWPSPDM",
        .pdm = "PDM",
        .psm = "PSM",
        .isvsm = "ISVSM",
    };
};
