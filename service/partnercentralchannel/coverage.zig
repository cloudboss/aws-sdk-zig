pub const Coverage = enum {
    entire_organization,
    management_account_only,

    pub const json_field_names = .{
        .entire_organization = "ENTIRE_ORGANIZATION",
        .management_account_only = "MANAGEMENT_ACCOUNT_ONLY",
    };
};
