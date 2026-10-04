const EnforcementMode = @import("enforcement_mode.zig").EnforcementMode;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;

/// Represents a metadata-only summary of a policy resource. This structure
/// contains resource identifiers, status, and timestamps without
/// customer-encrypted fields such as definition, description, or status
/// reasons. Policy summaries are returned by operations that do not require
/// access to the customer's KMS key.
pub const PolicySummary = struct {
    /// The timestamp when the policy was originally created.
    created_at: i64,

    /// The current enforcement mode of the policy.
    enforcement_mode: EnforcementMode = .active,

    /// The customer-assigned name of the policy.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the policy.
    policy_arn: []const u8,

    /// The identifier of the policy engine that manages this policy.
    policy_engine_id: []const u8,

    /// The unique identifier for the policy.
    policy_id: []const u8,

    /// The current status of the policy.
    status: PolicyStatus,

    /// The timestamp when the policy was last modified.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .enforcement_mode = "enforcementMode",
        .name = "name",
        .policy_arn = "policyArn",
        .policy_engine_id = "policyEngineId",
        .policy_id = "policyId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
