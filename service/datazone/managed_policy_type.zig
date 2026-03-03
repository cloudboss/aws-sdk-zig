const std = @import("std");

pub const ManagedPolicyType = enum {
    create_domain_unit,
    override_domain_unit_owners,
    add_to_project_member_pool,
    override_project_owners,
    create_glossary,
    create_form_type,
    create_asset_type,
    create_project,
    create_environment_profile,
    delegate_create_environment_profile,
    create_environment,
    create_environment_from_blueprint,
    create_project_from_project_profile,
    use_asset_type,

    pub const json_field_names = .{
        .create_domain_unit = "CREATE_DOMAIN_UNIT",
        .override_domain_unit_owners = "OVERRIDE_DOMAIN_UNIT_OWNERS",
        .add_to_project_member_pool = "ADD_TO_PROJECT_MEMBER_POOL",
        .override_project_owners = "OVERRIDE_PROJECT_OWNERS",
        .create_glossary = "CREATE_GLOSSARY",
        .create_form_type = "CREATE_FORM_TYPE",
        .create_asset_type = "CREATE_ASSET_TYPE",
        .create_project = "CREATE_PROJECT",
        .create_environment_profile = "CREATE_ENVIRONMENT_PROFILE",
        .delegate_create_environment_profile = "DELEGATE_CREATE_ENVIRONMENT_PROFILE",
        .create_environment = "CREATE_ENVIRONMENT",
        .create_environment_from_blueprint = "CREATE_ENVIRONMENT_FROM_BLUEPRINT",
        .create_project_from_project_profile = "CREATE_PROJECT_FROM_PROJECT_PROFILE",
        .use_asset_type = "USE_ASSET_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_domain_unit => "CREATE_DOMAIN_UNIT",
            .override_domain_unit_owners => "OVERRIDE_DOMAIN_UNIT_OWNERS",
            .add_to_project_member_pool => "ADD_TO_PROJECT_MEMBER_POOL",
            .override_project_owners => "OVERRIDE_PROJECT_OWNERS",
            .create_glossary => "CREATE_GLOSSARY",
            .create_form_type => "CREATE_FORM_TYPE",
            .create_asset_type => "CREATE_ASSET_TYPE",
            .create_project => "CREATE_PROJECT",
            .create_environment_profile => "CREATE_ENVIRONMENT_PROFILE",
            .delegate_create_environment_profile => "DELEGATE_CREATE_ENVIRONMENT_PROFILE",
            .create_environment => "CREATE_ENVIRONMENT",
            .create_environment_from_blueprint => "CREATE_ENVIRONMENT_FROM_BLUEPRINT",
            .create_project_from_project_profile => "CREATE_PROJECT_FROM_PROJECT_PROFILE",
            .use_asset_type => "USE_ASSET_TYPE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
