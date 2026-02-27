pub const IngressPointStatus = enum {
    provisioning,
    deprovisioning,
    updating,
    active,
    closed,
    failed,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .deprovisioning = "DEPROVISIONING",
        .updating = "UPDATING",
        .active = "ACTIVE",
        .closed = "CLOSED",
        .failed = "FAILED",
    };
};
