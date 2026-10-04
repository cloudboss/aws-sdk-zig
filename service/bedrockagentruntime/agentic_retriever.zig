const RetrieverConfiguration = @import("retriever_configuration.zig").RetrieverConfiguration;

/// A retriever used in agentic retrieval.
pub const AgenticRetriever = struct {
    /// The configuration for this retriever.
    configuration: RetrieverConfiguration,

    /// A description of the retriever's purpose.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .description = "description",
    };
};
