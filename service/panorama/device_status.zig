pub const DeviceStatus = enum {
    awaiting_provisioning,
    pending,
    succeeded,
    failed,
    @"error",
    deleting,

    pub const json_field_names = .{
        .awaiting_provisioning = "AWAITING_PROVISIONING",
        .pending = "PENDING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .@"error" = "ERROR",
        .deleting = "DELETING",
    };
};
