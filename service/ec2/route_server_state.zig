pub const RouteServerState = enum {
    pending,
    available,
    modifying,
    deleting,
    deleted,
};
