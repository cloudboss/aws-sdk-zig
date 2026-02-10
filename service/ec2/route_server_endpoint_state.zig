pub const RouteServerEndpointState = enum {
    pending,
    available,
    deleting,
    deleted,
    failing,
    failed,
    delete_failed,
};
