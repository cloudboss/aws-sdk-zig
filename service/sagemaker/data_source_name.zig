pub const DataSourceName = enum {
    salesforce_genie,
    snowflake,

    pub const json_field_names = .{
        .salesforce_genie = "SalesforceGenie",
        .snowflake = "Snowflake",
    };
};
