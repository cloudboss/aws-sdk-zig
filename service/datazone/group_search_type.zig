pub const GroupSearchType = enum {
    sso_group,
    datazone_sso_group,

    pub const json_field_names = .{
        .sso_group = "SSO_GROUP",
        .datazone_sso_group = "DATAZONE_SSO_GROUP",
    };
};
