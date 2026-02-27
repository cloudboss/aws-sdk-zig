pub const JobQueueType = enum {
    eks,
    ecs,
    ecs_fargate,
    sagemaker_training,

    pub const json_field_names = .{
        .eks = "EKS",
        .ecs = "ECS",
        .ecs_fargate = "ECS_FARGATE",
        .sagemaker_training = "SAGEMAKER_TRAINING",
    };
};
