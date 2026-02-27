pub const PrivateConnectionProvisioningStatus = enum {
    failed,
    pending,
    created,

    pub const json_field_names = .{
        .failed = "FAILED",
        .pending = "PENDING",
        .created = "CREATED",
    };
};
