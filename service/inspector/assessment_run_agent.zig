const AgentHealth = @import("agent_health.zig").AgentHealth;
const AgentHealthCode = @import("agent_health_code.zig").AgentHealthCode;
const TelemetryMetadata = @import("telemetry_metadata.zig").TelemetryMetadata;

/// Contains information about an Amazon Inspector agent. This data type is used
/// as a
/// response element in the ListAssessmentRunAgents action.
pub const AssessmentRunAgent = struct {
    /// The current health state of the agent.
    agent_health: AgentHealth,

    /// The detailed health state of the agent.
    agent_health_code: AgentHealthCode,

    /// The description for the agent health code.
    agent_health_details: ?[]const u8,

    /// The AWS account of the EC2 instance where the agent is installed.
    agent_id: []const u8,

    /// The ARN of the assessment run that is associated with the agent.
    assessment_run_arn: []const u8,

    /// The Auto Scaling group of the EC2 instance that is specified by the agent
    /// ID.
    auto_scaling_group: ?[]const u8,

    /// The Amazon Inspector application data metrics that are collected by the
    /// agent.
    telemetry_metadata: []const TelemetryMetadata,

    pub const json_field_names = .{
        .agent_health = "agentHealth",
        .agent_health_code = "agentHealthCode",
        .agent_health_details = "agentHealthDetails",
        .agent_id = "agentId",
        .assessment_run_arn = "assessmentRunArn",
        .auto_scaling_group = "autoScalingGroup",
        .telemetry_metadata = "telemetryMetadata",
    };
};
