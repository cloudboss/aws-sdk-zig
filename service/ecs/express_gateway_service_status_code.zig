pub const ExpressGatewayServiceStatusCode = enum {
    active,
    draining,
    inactive,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .draining = "DRAINING",
        .inactive = "INACTIVE",
    };
};
