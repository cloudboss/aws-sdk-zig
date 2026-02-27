pub const TransitGatewayRegistrationState = enum {
    pending,
    available,
    deleting,
    deleted,
    failed,

    pub const json_field_names = .{
        .pending = "pending",
        .available = "available",
        .deleting = "deleting",
        .deleted = "deleted",
        .failed = "failed",
    };
};
