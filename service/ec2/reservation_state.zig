pub const ReservationState = enum {
    active,
    expired,
    cancelled,
    scheduled,
    pending,
    failed,
    delayed,
    unsupported,
    payment_pending,
    payment_failed,
    retired,
};
