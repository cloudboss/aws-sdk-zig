pub const TargetEntityType = enum {
    domain_unit,
    environment_blueprint_configuration,
    environment_profile,
    asset_type,

    pub const json_field_names = .{
        .domain_unit = "DOMAIN_UNIT",
        .environment_blueprint_configuration = "ENVIRONMENT_BLUEPRINT_CONFIGURATION",
        .environment_profile = "ENVIRONMENT_PROFILE",
        .asset_type = "ASSET_TYPE",
    };
};
