pub const ActionType = enum {
    issue_certificate,
    get_certificate,
    list_permissions,

    pub const json_field_names = .{
        .issue_certificate = "IssueCertificate",
        .get_certificate = "GetCertificate",
        .list_permissions = "ListPermissions",
    };
};
