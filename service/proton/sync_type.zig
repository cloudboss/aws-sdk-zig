pub const SyncType = enum {
    /// Syncs environment and service templates to Proton.
    template_sync,
    /// Syncs services and service instances to Proton.
    service_sync,

    pub const json_field_names = .{
        .template_sync = "TEMPLATE_SYNC",
        .service_sync = "SERVICE_SYNC",
    };
};
