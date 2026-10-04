const AgenticRetrieveMemoryPersistenceMode = @import("agentic_retrieve_memory_persistence_mode.zig").AgenticRetrieveMemoryPersistenceMode;
const AgenticRetrieveMemoryRetrievalConfig = @import("agentic_retrieve_memory_retrieval_config.zig").AgenticRetrieveMemoryRetrievalConfig;
const AgenticRetrieveMemorySessionBinding = @import("agentic_retrieve_memory_session_binding.zig").AgenticRetrieveMemorySessionBinding;

/// Specifies an AgentCore Memory resource and how this retrieval uses it. Set
/// sessionBinding to restore and continue a session. Set retrievalConfigs to
/// let the agent retrieve from long-term memory. You must specify at least one
/// of the two.
pub const AgenticRetrieveMemoryConfiguration = struct {
    /// The identifier of the AgentCore Memory resource to use. The resource must
    /// exist in your account and be in the ACTIVE state.
    memory_id: []const u8,

    /// Specifies whether the agent-generated answer is written back to the given
    /// short-term memory session, and applies only when sessionBinding is set.
    /// Valid values:
    ///
    /// * `DEFAULT` (default) – Specifies that the question and the agent-generated
    ///   answer are persisted to the session as a single event. This value requires
    ///   generateResponse to be true.
    /// * `NONE` – Specifies that the session is left unchanged.
    persistence_mode: ?AgenticRetrieveMemoryPersistenceMode = null,

    /// Specifies the long-term memory configuration the agent can retrieve from.
    /// The agent decides whether to retrieve and composes its own query. This field
    /// currently accepts at most one entry.
    retrieval_configs: ?[]const AgenticRetrieveMemoryRetrievalConfig = null,

    /// The short-term memory session whose history is restored for this retrieval.
    /// To persist the agent-generated answer to the session, omit persistenceMode
    /// or set it to DEFAULT. To leave the session unchanged, set persistenceMode to
    /// NONE. Supply session history through the existing messages parameter or
    /// through short-term memory, but not both.
    session_binding: ?AgenticRetrieveMemorySessionBinding = null,

    pub const json_field_names = .{
        .memory_id = "memoryId",
        .persistence_mode = "persistenceMode",
        .retrieval_configs = "retrievalConfigs",
        .session_binding = "sessionBinding",
    };
};
