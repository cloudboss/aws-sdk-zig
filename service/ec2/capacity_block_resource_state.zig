pub const CapacityBlockResourceState = enum {
    active,
    expired,
    unavailable,
    cancelled,
    failed,
    scheduled,
    payment_pending,
    payment_failed,
};
