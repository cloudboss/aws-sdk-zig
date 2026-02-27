pub const OpportunitySortName = enum {
    last_modifieddate,
    identifier,
    customer_company_name,
    created_date,

    pub const json_field_names = .{
        .last_modifieddate = "LAST_MODIFIEDDATE",
        .identifier = "IDENTIFIER",
        .customer_company_name = "CUSTOMER_COMPANY_NAME",
        .created_date = "CREATED_DATE",
    };
};
