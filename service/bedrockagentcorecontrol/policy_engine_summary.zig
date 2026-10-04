const PolicyEngineStatus = @import("policy_engine_status.zig").PolicyEngineStatus;

/// Represents a metadata-only summary of a policy engine resource. This
/// structure contains resource identifiers, status, and timestamps without
/// customer-encrypted fields such as description or status reasons. Policy
/// engine summaries are returned by operations that do not require access to
/// the customer's KMS key.
pub const PolicyEngineSummary = struct {
    /// The timestamp when the policy engine was originally created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the policy
    /// engine data.
    encryption_key_arn: ?[]const u8 = null,

    /// The customer-assigned name of the policy engine.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the policy engine.
    policy_engine_arn: []const u8,

    /// The unique identifier for the policy engine.
    policy_engine_id: []const u8,

    /// The current status of the policy engine.
    status: PolicyEngineStatus,

    /// The timestamp when the policy engine was last modified.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .encryption_key_arn = "encryptionKeyArn",
        .name = "name",
        .policy_engine_arn = "policyEngineArn",
        .policy_engine_id = "policyEngineId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
