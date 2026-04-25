const PolicyEngineStatus = @import("policy_engine_status.zig").PolicyEngineStatus;

/// Represents a policy engine resource within the AgentCore Policy system.
/// Policy engines serve as containers for grouping related policies and provide
/// the execution context for policy evaluation and management. Each policy
/// engine can be associated with one Gateway (one engine per Gateway), where it
/// intercepts all agent tool calls and evaluates them against the contained
/// policies before allowing tools to execute. The policy engine maintains the
/// Cedar schema generated from the Gateway's tool manifest, ensuring that
/// policies are validated against the actual tools and parameters available.
/// Policy engines support two enforcement modes that can be configured when
/// associating with a Gateway: log-only mode for testing (evaluates decisions
/// without blocking) and enforce mode for production (actively allows or denies
/// based on policy evaluation).
pub const PolicyEngine = struct {
    /// The timestamp when the policy engine was originally created. This is
    /// automatically set by the service and used for auditing and lifecycle
    /// management.
    created_at: i64,

    /// A human-readable description of the policy engine's purpose and scope.
    /// Limited to 4,096 characters, this helps administrators understand the policy
    /// engine's role in the overall governance strategy.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the policy
    /// engine data.
    encryption_key_arn: ?[]const u8 = null,

    /// The customer-assigned immutable name for the policy engine. This
    /// human-readable identifier must be unique within the account and cannot
    /// exceed 48 characters.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the policy engine. This globally unique
    /// identifier can be used for cross-service references and IAM policy
    /// statements.
    policy_engine_arn: []const u8,

    /// The unique identifier for the policy engine. This system-generated
    /// identifier consists of the user name plus a 10-character generated suffix
    /// and serves as the primary key for policy engine operations.
    policy_engine_id: []const u8,

    /// The current status of the policy engine.
    status: PolicyEngineStatus,

    /// Additional information about the policy engine status. This provides details
    /// about any failures or the current state of the policy engine lifecycle.
    status_reasons: []const []const u8,

    /// The timestamp when the policy engine was last modified. This tracks the most
    /// recent changes to the policy engine configuration or metadata.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .encryption_key_arn = "encryptionKeyArn",
        .name = "name",
        .policy_engine_arn = "policyEngineArn",
        .policy_engine_id = "policyEngineId",
        .status = "status",
        .status_reasons = "statusReasons",
        .updated_at = "updatedAt",
    };
};
