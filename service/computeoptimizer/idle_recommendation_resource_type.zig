pub const IdleRecommendationResourceType = enum {
    ec2_instance,
    auto_scaling_group,
    ebs_volume,
    ecs_service,
    rds_db_instance,
    nat_gateway,

    pub const json_field_names = .{
        .ec2_instance = "EC2_INSTANCE",
        .auto_scaling_group = "AUTO_SCALING_GROUP",
        .ebs_volume = "EBS_VOLUME",
        .ecs_service = "ECS_SERVICE",
        .rds_db_instance = "RDS_DB_INSTANCE",
        .nat_gateway = "NAT_GATEWAY",
    };
};
