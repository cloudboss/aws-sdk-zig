pub const AccountType = enum {
    team,
    enterprise_directory,
    enterprise_lwa,
    enterprise_oidc,

    pub const json_field_names = .{
        .team = "Team",
        .enterprise_directory = "EnterpriseDirectory",
        .enterprise_lwa = "EnterpriseLWA",
        .enterprise_oidc = "EnterpriseOIDC",
    };
};
