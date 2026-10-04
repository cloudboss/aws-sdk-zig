const HarnessManagedMemoryStrategyType = @import("harness_managed_memory_strategy_type.zig").HarnessManagedMemoryStrategyType;

/// Configuration for managed memory creation.
pub const HarnessManagedMemoryConfiguration = struct {
    /// The ARN of the managed AgentCore Memory resource. Read-only on Get, ignored
    /// on Create/Update input.
    arn: ?[]const u8 = null,

    /// Customer-managed KMS key. Defaults to AWS-owned key. Not updatable after
    /// creation.
    encryption_key_arn: ?[]const u8 = null,

    /// Event retention in days. Defaults to 30.
    event_expiry_duration: ?i32 = null,

    /// Strategy types to enable. Defaults to [SEMANTIC, SUMMARIZATION].
    strategies: ?[]const HarnessManagedMemoryStrategyType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .encryption_key_arn = "encryptionKeyArn",
        .event_expiry_duration = "eventExpiryDuration",
        .strategies = "strategies",
    };
};
