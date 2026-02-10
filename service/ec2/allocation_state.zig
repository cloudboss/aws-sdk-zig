pub const AllocationState = enum {
    available,
    under_assessment,
    permanent_failure,
    released,
    released_permanent_failure,
    pending,
};
