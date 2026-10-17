/// The requirements for running a Runtime Monitoring custom detection rule on
/// Amazon ECS with the Fargate launch type.
pub const DetectionRuleEcsFargateRequirements = struct {
    /// The minimum GuardDuty agent version required to run the rule on Amazon ECS
    /// with the Fargate launch type.
    min_agent_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .min_agent_version = "MinAgentVersion",
    };
};
