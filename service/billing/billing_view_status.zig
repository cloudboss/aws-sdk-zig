pub const BillingViewStatus = enum {
    healthy,
    unhealthy,
    creating,
    updating,

    pub const json_field_names = .{
        .healthy = "HEALTHY",
        .unhealthy = "UNHEALTHY",
        .creating = "CREATING",
        .updating = "UPDATING",
    };
};
