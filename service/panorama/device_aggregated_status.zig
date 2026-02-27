pub const DeviceAggregatedStatus = enum {
    @"error",
    awaiting_provisioning,
    pending,
    failed,
    deleting,
    online,
    offline,
    lease_expired,
    update_needed,
    rebooting,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .awaiting_provisioning = "AWAITING_PROVISIONING",
        .pending = "PENDING",
        .failed = "FAILED",
        .deleting = "DELETING",
        .online = "ONLINE",
        .offline = "OFFLINE",
        .lease_expired = "LEASE_EXPIRED",
        .update_needed = "UPDATE_NEEDED",
        .rebooting = "REBOOTING",
    };
};
