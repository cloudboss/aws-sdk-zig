pub const RoutingStrategy = enum {
    least_outstanding_requests,
    random,

    pub const json_field_names = .{
        .least_outstanding_requests = "LEAST_OUTSTANDING_REQUESTS",
        .random = "RANDOM",
    };
};
