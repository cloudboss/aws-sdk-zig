pub const ApplicationPermission = enum {
    create_dataset,
    manage_clusters,
    manage_users_and_groups,
    manage_attribute_sets,
    view_audit_data,
    access_notebooks,
    get_temporary_credentials,

    pub const json_field_names = .{
        .create_dataset = "CreateDataset",
        .manage_clusters = "ManageClusters",
        .manage_users_and_groups = "ManageUsersAndGroups",
        .manage_attribute_sets = "ManageAttributeSets",
        .view_audit_data = "ViewAuditData",
        .access_notebooks = "AccessNotebooks",
        .get_temporary_credentials = "GetTemporaryCredentials",
    };
};
