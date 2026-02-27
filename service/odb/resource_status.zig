pub const ResourceStatus = enum {
    available,
    failed,
    provisioning,
    terminated,
    terminating,
    updating,
    maintenance_in_progress,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .failed = "FAILED",
        .provisioning = "PROVISIONING",
        .terminated = "TERMINATED",
        .terminating = "TERMINATING",
        .updating = "UPDATING",
        .maintenance_in_progress = "MAINTENANCE_IN_PROGRESS",
    };
};
