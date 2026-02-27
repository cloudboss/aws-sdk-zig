pub const TargetHealthStateEnum = enum {
    initial,
    healthy,
    unhealthy,
    unhealthy_draining,
    unused,
    draining,
    unavailable,
};
