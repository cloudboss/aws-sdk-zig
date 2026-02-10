pub const FleetStateCode = enum {
    submitted,
    active,
    deleted,
    failed,
    deleted_running,
    deleted_terminating_instances,
    modifying,
};
