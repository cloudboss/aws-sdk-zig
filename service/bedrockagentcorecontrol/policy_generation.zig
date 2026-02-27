const Resource = @import("resource.zig").Resource;
const PolicyGenerationStatus = @import("policy_generation_status.zig").PolicyGenerationStatus;

/// Represents a policy generation request within the AgentCore Policy system.
/// Tracks the AI-powered conversion of natural language descriptions into Cedar
/// policy statements, enabling users to author policies by describing
/// authorization requirements in plain English. The generation process analyzes
/// the natural language input along with the Gateway's tool context and Cedar
/// schema to produce one or more validated policy options. Each generation
/// request tracks the status of the conversion process and maintains findings
/// about the generated policies, including validation results and potential
/// issues. Generated policy assets remain available for one week after
/// successful generation, allowing time to review and create policies from the
/// generated options.
pub const PolicyGeneration = struct {
    /// The timestamp when this policy generation request was created.
    created_at: i64,

    /// Findings and insights from this policy generation process.
    findings: ?[]const u8,

    /// The customer-assigned name for this policy generation request.
    name: []const u8,

    /// The identifier of the policy engine associated with this generation request.
    policy_engine_id: []const u8,

    /// The ARN of this policy generation request.
    policy_generation_arn: []const u8,

    /// The unique identifier for this policy generation request.
    policy_generation_id: []const u8,

    /// The resource information associated with this policy generation.
    resource: Resource,

    /// The current status of this policy generation request.
    status: PolicyGenerationStatus,

    /// Additional information about the generation status.
    status_reasons: []const []const u8,

    /// The timestamp when this policy generation was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .findings = "findings",
        .name = "name",
        .policy_engine_id = "policyEngineId",
        .policy_generation_arn = "policyGenerationArn",
        .policy_generation_id = "policyGenerationId",
        .resource = "resource",
        .status = "status",
        .status_reasons = "statusReasons",
        .updated_at = "updatedAt",
    };
};
