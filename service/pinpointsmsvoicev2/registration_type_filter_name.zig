pub const RegistrationTypeFilterName = enum {
    supported_association_resource_type,
    supported_association_iso_country_code,

    pub const json_field_names = .{
        .supported_association_resource_type = "SUPPORTED_ASSOCIATION_RESOURCE_TYPE",
        .supported_association_iso_country_code = "SUPPORTED_ASSOCIATION_ISO_COUNTRY_CODE",
    };
};
