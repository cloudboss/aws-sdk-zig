pub const stateType = enum {
    unassigned,
    assigned,
    pending_approval,
    finalized,
    accepted,
    rejected,
    expired,
};
