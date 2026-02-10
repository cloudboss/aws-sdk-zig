pub const RouteServerPeerState = enum {
    pending,
    available,
    deleting,
    deleted,
    failing,
    failed,
};
