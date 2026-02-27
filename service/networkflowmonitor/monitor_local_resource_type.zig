pub const MonitorLocalResourceType = enum {
    aws_vpc,
    aws_az,
    aws_subnet,
    aws_region,
    eks_cluster,

    pub const json_field_names = .{
        .aws_vpc = "AWS_VPC",
        .aws_az = "AWS_AZ",
        .aws_subnet = "AWS_SUBNET",
        .aws_region = "AWS_REGION",
        .eks_cluster = "EKS_CLUSTER",
    };
};
