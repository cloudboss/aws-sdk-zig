pub const CapacityReservationFleetState = enum {
    submitted,
    modifying,
    active,
    partially_fulfilled,
    expiring,
    expired,
    cancelling,
    cancelled,
    failed,
};
