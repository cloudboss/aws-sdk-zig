pub const ClusterStatus = enum {
    creating,
    updating,
    deleting,
    available,
    failed,
    deleted,
    maintenance,
    updating_instance_type,
    rebooting,
    reboot_failed,
    partially_available,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .available = "AVAILABLE",
        .failed = "FAILED",
        .deleted = "DELETED",
        .maintenance = "MAINTENANCE",
        .updating_instance_type = "UPDATING_INSTANCE_TYPE",
        .rebooting = "REBOOTING",
        .reboot_failed = "REBOOT_FAILED",
        .partially_available = "PARTIALLY_AVAILABLE",
    };
};
