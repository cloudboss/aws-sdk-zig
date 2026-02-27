pub const TargetGroupType = enum {
    /// Indicates targets in this target group are IP
    ip,
    /// Indicates targets in this target group are Lambda
    lambda,
    /// Indicates targets in this target group are EC2 instances
    instance,
    /// Indicates target in this target group is an ALB
    alb,

    pub const json_field_names = .{
        .ip = "IP",
        .lambda = "LAMBDA",
        .instance = "INSTANCE",
        .alb = "ALB",
    };
};
