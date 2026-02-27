pub const Status = enum {
    creating,
    available,
    deleting,
    modifying,
    updating,
    deleted,
    failed,
    updating_deployment_type,
    updating_instance_type,
    maintenance,
    rebooting,
    reboot_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .deleting = "DELETING",
        .modifying = "MODIFYING",
        .updating = "UPDATING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .updating_deployment_type = "UPDATING_DEPLOYMENT_TYPE",
        .updating_instance_type = "UPDATING_INSTANCE_TYPE",
        .maintenance = "MAINTENANCE",
        .rebooting = "REBOOTING",
        .reboot_failed = "REBOOT_FAILED",
    };
};
