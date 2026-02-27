pub const OrgFeatureAdditionalConfiguration = enum {
    eks_addon_management,
    ecs_fargate_agent_management,
    ec2_agent_management,

    pub const json_field_names = .{
        .eks_addon_management = "EKS_ADDON_MANAGEMENT",
        .ecs_fargate_agent_management = "ECS_FARGATE_AGENT_MANAGEMENT",
        .ec2_agent_management = "EC2_AGENT_MANAGEMENT",
    };
};
