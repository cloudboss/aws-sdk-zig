pub const AWSServiceName = enum {
    aws,
    ec2,
    elasticache,
    elb,
    rds,
    route53,

    pub const json_field_names = .{
        .aws = "AWS",
        .ec2 = "EC2",
        .elasticache = "ELASTICACHE",
        .elb = "ELB",
        .rds = "RDS",
        .route53 = "ROUTE53",
    };
};
