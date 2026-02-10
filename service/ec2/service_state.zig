pub const ServiceState = enum {
    pending,
    available,
    deleting,
    deleted,
    failed,
};
