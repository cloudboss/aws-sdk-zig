pub const ExecutionBlockType = enum {
    custom_action_lambda,
    execution_approval,
    aurora,
    ec2_asg,
    routing_control,
    region_switch,
    parallel,
    ecs,
    eks_resource_scaling,
    route53_health_check,
    documentdb,

    pub const json_field_names = .{
        .custom_action_lambda = "CUSTOM_ACTION_LAMBDA",
        .execution_approval = "EXECUTION_APPROVAL",
        .aurora = "AURORA",
        .ec2_asg = "EC2_ASG",
        .routing_control = "ROUTING_CONTROL",
        .region_switch = "REGION_SWITCH",
        .parallel = "PARALLEL",
        .ecs = "ECS",
        .eks_resource_scaling = "EKS_RESOURCE_SCALING",
        .route53_health_check = "ROUTE53_HEALTH_CHECK",
        .documentdb = "DOCUMENTDB",
    };
};
