pub const MonitorRemoteResourceType = enum {
    aws_vpc,
    aws_az,
    aws_subnet,
    aws_service,
    aws_region,

    pub const json_field_names = .{
        .aws_vpc = "AWS_VPC",
        .aws_az = "AWS_AZ",
        .aws_subnet = "AWS_SUBNET",
        .aws_service = "AWS_SERVICE",
        .aws_region = "AWS_REGION",
    };
};
