const Resource = @import("resource.zig").Resource;
const PolicyGenerationStatus = @import("policy_generation_status.zig").PolicyGenerationStatus;

/// Represents a metadata-only summary of a policy generation resource. This
/// structure contains resource identifiers, status, timestamps, and findings
/// without customer-encrypted fields such as status reasons. Policy generation
/// summaries are returned by operations that do not require access to the
/// customer's KMS key.
pub const PolicyGenerationSummary = struct {
    /// The timestamp when this policy generation request was created.
    created_at: i64,

    /// Findings and insights from this policy generation process.
    findings: ?[]const u8 = null,

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
        .updated_at = "updatedAt",
    };
};
