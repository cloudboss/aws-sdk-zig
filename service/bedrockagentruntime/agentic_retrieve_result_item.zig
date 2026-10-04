const aws = @import("aws");

const RetrievalContent = @import("retrieval_content.zig").RetrievalContent;
const AgenticRetrieveSourceRetriever = @import("agentic_retrieve_source_retriever.zig").AgenticRetrieveSourceRetriever;

/// A single item from the agentic retrieval results.
pub const AgenticRetrieveResultItem = struct {
    /// The retrieved content.
    content: RetrievalContent,

    /// Metadata associated with the retrieved item.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The source retriever that produced this result.
    source_retriever: AgenticRetrieveSourceRetriever,

    pub const json_field_names = .{
        .content = "content",
        .metadata = "metadata",
        .source_retriever = "sourceRetriever",
    };
};
