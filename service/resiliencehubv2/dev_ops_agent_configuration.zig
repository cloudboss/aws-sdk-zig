/// The AWS DevOps Agent (DevOps Agent) integration configuration that you
/// supply when creating or updating a service. Connecting a service to a DevOps
/// Agent Agent Space lets DevOps Agent investigate the service's resilience
/// test runs and attach its analysis to the results. Include this block with an
/// Agent Space Amazon Resource Name (ARN) to connect or reconnect the service
/// to an Agent Space. Include it without an Agent Space ARN to disconnect the
/// service. Omit it to leave the existing linkage unchanged.
pub const DevOpsAgentConfiguration = struct {
    /// The ARN of the DevOps Agent Agent Space to link to this service.
    agent_space_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_space_arn = "agentSpaceArn",
    };
};
