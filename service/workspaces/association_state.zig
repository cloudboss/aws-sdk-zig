pub const AssociationState = enum {
    pending_install,
    pending_install_deployment,
    pending_uninstall,
    pending_uninstall_deployment,
    installing,
    uninstalling,
    @"error",
    completed,
    removed,

    pub const json_field_names = .{
        .pending_install = "PENDING_INSTALL",
        .pending_install_deployment = "PENDING_INSTALL_DEPLOYMENT",
        .pending_uninstall = "PENDING_UNINSTALL",
        .pending_uninstall_deployment = "PENDING_UNINSTALL_DEPLOYMENT",
        .installing = "INSTALLING",
        .uninstalling = "UNINSTALLING",
        .@"error" = "ERROR",
        .completed = "COMPLETED",
        .removed = "REMOVED",
    };
};
