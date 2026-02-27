pub const PoolOriginationIdentitiesFilterName = enum {
    iso_country_code,
    number_capability,

    pub const json_field_names = .{
        .iso_country_code = "ISO_COUNTRY_CODE",
        .number_capability = "NUMBER_CAPABILITY",
    };
};
