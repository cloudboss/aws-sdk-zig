pub const ProtectedResourceType = enum {
    cloudfront_distribution,
    route_53_hosted_zone,
    elastic_ip_allocation,
    classic_load_balancer,
    application_load_balancer,
    global_accelerator,

    pub const json_field_names = .{
        .cloudfront_distribution = "CLOUDFRONT_DISTRIBUTION",
        .route_53_hosted_zone = "ROUTE_53_HOSTED_ZONE",
        .elastic_ip_allocation = "ELASTIC_IP_ALLOCATION",
        .classic_load_balancer = "CLASSIC_LOAD_BALANCER",
        .application_load_balancer = "APPLICATION_LOAD_BALANCER",
        .global_accelerator = "GLOBAL_ACCELERATOR",
    };
};
