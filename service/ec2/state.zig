pub const State = enum {
    pending_acceptance,
    pending,
    available,
    deleting,
    deleted,
    rejected,
    failed,
    expired,
    partial,
};
