const PolicyDefinition = @import("policy_definition.zig").PolicyDefinition;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;

/// Represents a complete policy resource within the AgentCore Policy system.
/// Policies are ARN-able resources that contain Cedar policy statements and
/// associated metadata for controlling agent behavior and access decisions.
/// Each policy belongs to a policy engine and defines fine-grained
/// authorization rules that are evaluated in real-time as agents interact with
/// tools through Gateway. Policies use the Cedar policy language to specify who
/// (principals based on OAuth claims like username, role, or scope) can perform
/// what actions (tool calls) on which resources (Gateways), with optional
/// conditions for attribute-based access control. Multiple policies can apply
/// to a single request, with Cedar's forbid-wins semantics ensuring that
/// security restrictions are never accidentally overridden.
pub const Policy = struct {
    /// The timestamp when the policy was originally created. This is automatically
    /// set by the service and used for auditing and lifecycle management.
    created_at: i64,

    /// The Cedar policy statement that defines the access control rules. This
    /// contains the actual policy logic used for agent behavior control and access
    /// decisions.
    definition: PolicyDefinition,

    /// A human-readable description of the policy's purpose and functionality.
    /// Limited to 4,096 characters, this helps administrators understand and manage
    /// the policy.
    description: ?[]const u8,

    /// The customer-assigned immutable name for the policy. This human-readable
    /// identifier must be unique within the account and cannot exceed 48
    /// characters.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the policy. This globally unique
    /// identifier can be used for cross-service references and IAM policy
    /// statements.
    policy_arn: []const u8,

    /// The identifier of the policy engine that manages this policy. This
    /// establishes the policy engine context for policy evaluation and management.
    policy_engine_id: []const u8,

    /// The unique identifier for the policy. This system-generated identifier
    /// consists of the user name plus a 10-character generated suffix and serves as
    /// the primary key for policy operations.
    policy_id: []const u8,

    /// The current status of the policy.
    status: PolicyStatus,

    /// Additional information about the policy status. This provides details about
    /// any failures or the current state of the policy lifecycle.
    status_reasons: []const []const u8,

    /// The timestamp when the policy was last modified. This tracks the most recent
    /// changes to the policy configuration or metadata.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .definition = "definition",
        .description = "description",
        .name = "name",
        .policy_arn = "policyArn",
        .policy_engine_id = "policyEngineId",
        .policy_id = "policyId",
        .status = "status",
        .status_reasons = "statusReasons",
        .updated_at = "updatedAt",
    };
};
