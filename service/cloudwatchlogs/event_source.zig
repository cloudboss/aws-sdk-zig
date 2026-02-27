pub const EventSource = enum {
    cloud_trail,
    route53_resolver,
    vpc_flow,
    eks_audit,
    awswaf,

    pub const json_field_names = .{
        .cloud_trail = "CLOUD_TRAIL",
        .route53_resolver = "ROUTE53_RESOLVER",
        .vpc_flow = "VPC_FLOW",
        .eks_audit = "EKS_AUDIT",
        .awswaf = "AWSWAF",
    };
};
