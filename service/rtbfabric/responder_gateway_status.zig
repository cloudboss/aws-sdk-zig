pub const ResponderGatewayStatus = enum {
    pending_creation,
    active,
    pending_deletion,
    deleted,
    @"error",
    pending_update,
    isolated,
    pending_isolation,
    pending_restoration,

    pub const json_field_names = .{
        .pending_creation = "PENDING_CREATION",
        .active = "ACTIVE",
        .pending_deletion = "PENDING_DELETION",
        .deleted = "DELETED",
        .@"error" = "ERROR",
        .pending_update = "PENDING_UPDATE",
        .isolated = "ISOLATED",
        .pending_isolation = "PENDING_ISOLATION",
        .pending_restoration = "PENDING_RESTORATION",
    };
};
