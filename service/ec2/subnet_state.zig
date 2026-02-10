pub const SubnetState = enum {
    pending,
    available,
    unavailable,
    failed,
    failed_insufficient_capacity,
};
