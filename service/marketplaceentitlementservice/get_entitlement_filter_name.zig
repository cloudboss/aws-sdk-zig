pub const GetEntitlementFilterName = enum {
    customer_identifier,
    dimension,
    customer_aws_account_id,

    pub const json_field_names = .{
        .customer_identifier = "CUSTOMER_IDENTIFIER",
        .dimension = "DIMENSION",
        .customer_aws_account_id = "CUSTOMER_AWS_ACCOUNT_ID",
    };
};
