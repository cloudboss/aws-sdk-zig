const AgenticRetrieveMessageContent = @import("agentic_retrieve_message_content.zig").AgenticRetrieveMessageContent;
const AgenticRetrieveSourceRetriever = @import("agentic_retrieve_source_retriever.zig").AgenticRetrieveSourceRetriever;

/// Details of a retrieve action including the query and target retrievers.
pub const AgenticRetrieveActionDetails = struct {
    /// The input query used for retrieval.
    input_query: AgenticRetrieveMessageContent,

    /// The list of source retrievers targeted by this action.
    source_retrievers: []const AgenticRetrieveSourceRetriever,

    pub const json_field_names = .{
        .input_query = "inputQuery",
        .source_retrievers = "sourceRetrievers",
    };
};
