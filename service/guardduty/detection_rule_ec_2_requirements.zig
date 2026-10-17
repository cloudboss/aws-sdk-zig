/// The requirements for running a Runtime Monitoring custom detection rule on
/// Amazon EC2.
pub const DetectionRuleEc2Requirements = struct {
    /// The minimum GuardDuty agent version required to run the rule on Amazon EC2.
    min_agent_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .min_agent_version = "MinAgentVersion",
    };
};
