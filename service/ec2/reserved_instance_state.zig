pub const ReservedInstanceState = enum {
    payment_pending,
    active,
    payment_failed,
    retired,
    queued,
    queued_deleted,
};
