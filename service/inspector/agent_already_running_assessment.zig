/// Used in the exception error that is thrown if you start an assessment run
/// for an
/// assessment target that includes an EC2 instance that is already
/// participating in another
/// started assessment run.
pub const AgentAlreadyRunningAssessment = struct {
    /// ID of the agent that is running on an EC2 instance that is already
    /// participating in
    /// another started assessment run.
    agent_id: []const u8,

    /// The ARN of the assessment run that has already been started.
    assessment_run_arn: []const u8,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .assessment_run_arn = "assessmentRunArn",
    };
};
