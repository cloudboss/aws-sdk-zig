pub const AppConfigType = enum {
    opensearch_dashboard_admin_users,
    opensearch_dashboard_admin_groups,

    pub const json_field_names = .{
        .opensearch_dashboard_admin_users = "OpensearchDashboardAdminUsers",
        .opensearch_dashboard_admin_groups = "OpensearchDashboardAdminGroups",
    };
};
