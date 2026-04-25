const aws = @import("aws");

const HarnessAgentCoreMemoryRetrievalConfig = @import("harness_agent_core_memory_retrieval_config.zig").HarnessAgentCoreMemoryRetrievalConfig;

/// Configuration for AgentCore Memory integration.
pub const HarnessAgentCoreMemoryConfiguration = struct {
    /// The actor ID for memory operations.
    actor_id: ?[]const u8 = null,

    /// The ARN of the AgentCore Memory resource.
    arn: []const u8,

    /// The number of messages to retrieve from memory.
    messages_count: ?i32 = null,

    /// The retrieval configuration for long-term memory, mapping namespace path
    /// templates to retrieval settings.
    retrieval_config: ?[]const aws.map.MapEntry(HarnessAgentCoreMemoryRetrievalConfig) = null,

    pub const json_field_names = .{
        .actor_id = "actorId",
        .arn = "arn",
        .messages_count = "messagesCount",
        .retrieval_config = "retrievalConfig",
    };
};
