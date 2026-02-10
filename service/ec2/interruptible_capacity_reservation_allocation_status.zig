pub const InterruptibleCapacityReservationAllocationStatus = enum {
    pending,
    active,
    updating,
    canceling,
    canceled,
    failed,
};
