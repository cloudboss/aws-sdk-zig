pub const CapacityReservationState = enum {
    active,
    expired,
    cancelled,
    pending,
    failed,
    scheduled,
    payment_pending,
    payment_failed,
    assessing,
    delayed,
    unsupported,
    unavailable,
};
