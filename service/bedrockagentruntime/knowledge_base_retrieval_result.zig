const aws = @import("aws");

const RetrievalResultContent = @import("retrieval_result_content.zig").RetrievalResultContent;
const RetrievalResultLocation = @import("retrieval_result_location.zig").RetrievalResultLocation;

/// Details about a result from querying the knowledge base.
///
/// This data type is used in the following API operations:
///
/// * [Retrieve
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Retrieve.html#API_agent-runtime_Retrieve_ResponseSyntax) – in the `retrievalResults` field
pub const KnowledgeBaseRetrievalResult = struct {
    /// Contains information about the content of the chunk.
    content: RetrievalResultContent,

    /// Contains information about the location of the data source.
    location: ?RetrievalResultLocation,

    /// Contains metadata attributes and their values for the file in the data
    /// source. For more information, see [Metadata and
    /// filtering](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-ds.html#kb-ds-metadata).
    metadata: ?[]const aws.map.StringMapEntry,

    /// The level of relevance of the result to the query.
    score: ?f64,

    pub const json_field_names = .{
        .content = "content",
        .location = "location",
        .metadata = "metadata",
        .score = "score",
    };
};
