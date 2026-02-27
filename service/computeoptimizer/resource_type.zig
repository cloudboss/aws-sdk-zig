pub const ResourceType = enum {
    ec2_instance,
    auto_scaling_group,
    ebs_volume,
    lambda_function,
    not_applicable,
    ecs_service,
    license,
    rds_db_instance,
    aurora_db_cluster_storage,
    idle,

    pub const json_field_names = .{
        .ec2_instance = "EC2_INSTANCE",
        .auto_scaling_group = "AUTO_SCALING_GROUP",
        .ebs_volume = "EBS_VOLUME",
        .lambda_function = "LAMBDA_FUNCTION",
        .not_applicable = "NOT_APPLICABLE",
        .ecs_service = "ECS_SERVICE",
        .license = "LICENSE",
        .rds_db_instance = "RDS_DB_INSTANCE",
        .aurora_db_cluster_storage = "AURORA_DB_CLUSTER_STORAGE",
        .idle = "IDLE",
    };
};
