const aws = @import("aws");

const RetrievalContent = @import("retrieval_content.zig").RetrievalContent;
const AgenticRetrieveSourceRetriever = @import("agentic_retrieve_source_retriever.zig").AgenticRetrieveSourceRetriever;

/// A result item from an agentic retrieval trace.
pub const AgenticRetrieveTraceResultItem = struct {
    /// The retrieved content.
    content: ?RetrievalContent = null,

    /// Metadata associated with the retrieved item.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The source retriever that produced this result.
    source_retriever: ?AgenticRetrieveSourceRetriever = null,

    pub const json_field_names = .{
        .content = "content",
        .metadata = "metadata",
        .source_retriever = "sourceRetriever",
    };
};
