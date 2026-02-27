pub const PhoneNumberFilterName = enum {
    status,
    iso_country_code,
    message_type,
    number_capability,
    number_type,
    two_way_enabled,
    self_managed_opt_outs_enabled,
    opt_out_list_name,
    deletion_protection_enabled,
    two_way_channel_arn,

    pub const json_field_names = .{
        .status = "STATUS",
        .iso_country_code = "ISO_COUNTRY_CODE",
        .message_type = "MESSAGE_TYPE",
        .number_capability = "NUMBER_CAPABILITY",
        .number_type = "NUMBER_TYPE",
        .two_way_enabled = "TWO_WAY_ENABLED",
        .self_managed_opt_outs_enabled = "SELF_MANAGED_OPT_OUTS_ENABLED",
        .opt_out_list_name = "OPT_OUT_LIST_NAME",
        .deletion_protection_enabled = "DELETION_PROTECTION_ENABLED",
        .two_way_channel_arn = "TWO_WAY_CHANNEL_ARN",
    };
};
