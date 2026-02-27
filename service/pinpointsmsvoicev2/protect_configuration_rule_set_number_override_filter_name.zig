pub const ProtectConfigurationRuleSetNumberOverrideFilterName = enum {
    iso_country_code,
    destination_phone_number_begins_with,
    action,
    expires_before,
    expires_after,
    created_before,
    created_after,

    pub const json_field_names = .{
        .iso_country_code = "ISO_COUNTRY_CODE",
        .destination_phone_number_begins_with = "DESTINATION_PHONE_NUMBER_BEGINS_WITH",
        .action = "ACTION",
        .expires_before = "EXPIRES_BEFORE",
        .expires_after = "EXPIRES_AFTER",
        .created_before = "CREATED_BEFORE",
        .created_after = "CREATED_AFTER",
    };
};
