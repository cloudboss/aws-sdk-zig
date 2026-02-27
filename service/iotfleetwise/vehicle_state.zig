pub const VehicleState = enum {
    created,
    ready,
    healthy,
    suspended,
    deleting,
    ready_for_checkin,

    pub const json_field_names = .{
        .created = "CREATED",
        .ready = "READY",
        .healthy = "HEALTHY",
        .suspended = "SUSPENDED",
        .deleting = "DELETING",
        .ready_for_checkin = "READY_FOR_CHECKIN",
    };
};
