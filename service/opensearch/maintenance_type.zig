pub const MaintenanceType = enum {
    reboot_node,
    restart_search_process,
    restart_dashboard,

    pub const json_field_names = .{
        .reboot_node = "REBOOT_NODE",
        .restart_search_process = "RESTART_SEARCH_PROCESS",
        .restart_dashboard = "RESTART_DASHBOARD",
    };
};
