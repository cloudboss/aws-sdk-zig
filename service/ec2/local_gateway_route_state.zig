pub const LocalGatewayRouteState = enum {
    pending,
    active,
    blackhole,
    deleting,
    deleted,
};
