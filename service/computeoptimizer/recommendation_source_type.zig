pub const RecommendationSourceType = enum {
    ec2_instance,
    auto_scaling_group,
    ebs_volume,
    lambda_function,
    ecs_service,
    license,
    rds_db_instance,
    rds_db_instance_storage,
    aurora_db_cluster_storage,
    nat_gateway,

    pub const json_field_names = .{
        .ec2_instance = "EC2_INSTANCE",
        .auto_scaling_group = "AUTO_SCALING_GROUP",
        .ebs_volume = "EBS_VOLUME",
        .lambda_function = "LAMBDA_FUNCTION",
        .ecs_service = "ECS_SERVICE",
        .license = "LICENSE",
        .rds_db_instance = "RDS_DB_INSTANCE",
        .rds_db_instance_storage = "RDS_DB_INSTANCE_STORAGE",
        .aurora_db_cluster_storage = "AURORA_DB_CLUSTER_STORAGE",
        .nat_gateway = "NAT_GATEWAY",
    };
};
