pub const RegistrationAssociationFilterName = enum {
    resource_type,
    iso_country_code,

    pub const json_field_names = .{
        .resource_type = "RESOURCE_TYPE",
        .iso_country_code = "ISO_COUNTRY_CODE",
    };
};
