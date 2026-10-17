const DetectionRuleEc2Requirements = @import("detection_rule_ec_2_requirements.zig").DetectionRuleEc2Requirements;
const DetectionRuleEcsFargateRequirements = @import("detection_rule_ecs_fargate_requirements.zig").DetectionRuleEcsFargateRequirements;
const DetectionRuleEksRequirements = @import("detection_rule_eks_requirements.zig").DetectionRuleEksRequirements;

/// The platforms on which a Runtime Monitoring custom detection rule can run. A
/// member's presence is the support statement: when present, the rule runs on
/// that platform and `minAgentVersion` is the minimum GuardDuty agent version
/// required there. When absent, the rule cannot run on that platform at any
/// agent version.
pub const DetectionRuleRuntimePlatforms = struct {
    /// The requirements for running the rule on Amazon EC2.
    ec_2: ?DetectionRuleEc2Requirements = null,

    /// The requirements for running the rule on Amazon ECS with the Fargate launch
    /// type.
    ecs_fargate: ?DetectionRuleEcsFargateRequirements = null,

    /// The requirements for running the rule on Amazon EKS.
    eks: ?DetectionRuleEksRequirements = null,

    pub const json_field_names = .{
        .ec_2 = "Ec2",
        .ecs_fargate = "EcsFargate",
        .eks = "Eks",
    };
};
