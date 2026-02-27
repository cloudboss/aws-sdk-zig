pub const ResolverLevelMetricsBehavior = enum {
    full_request_resolver_metrics,
    per_resolver_metrics,

    pub const json_field_names = .{
        .full_request_resolver_metrics = "FULL_REQUEST_RESOLVER_METRICS",
        .per_resolver_metrics = "PER_RESOLVER_METRICS",
    };
};
