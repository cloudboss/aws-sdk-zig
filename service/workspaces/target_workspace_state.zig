pub const TargetWorkspaceState = enum {
    available,
    admin_maintenance,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .admin_maintenance = "ADMIN_MAINTENANCE",
    };
};
