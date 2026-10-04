const AgenticRetrieveMessageContent = @import("agentic_retrieve_message_content.zig").AgenticRetrieveMessageContent;

/// A long-term memory retrieval that the agent chose to perform. The record
/// reports the query and the namespace. The corresponding Retrieval step
/// reports the results.
pub const AgenticRetrieveMemoryRetrieveDetails = struct {
    /// The query that the agent composed.
    input_query: AgenticRetrieveMessageContent,

    /// The identifier of the AgentCore Memory resource retrieved from.
    memory_id: []const u8,

    /// The namespace prefix retrieved from, as supplied in the request. This field
    /// is present when the request specified namespace.
    namespace: ?[]const u8 = null,

    /// The parent namespace retrieved from hierarchically, as supplied in the
    /// request. This field is present when the request specified namespacePath.
    namespace_path: ?[]const u8 = null,

    /// The extraction strategy that restricted retrieval, if the request specified
    /// one.
    strategy_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .input_query = "inputQuery",
        .memory_id = "memoryId",
        .namespace = "namespace",
        .namespace_path = "namespacePath",
        .strategy_id = "strategyId",
    };
};
