const aws = @import("aws");

const RetrievalResultContent = @import("retrieval_result_content.zig").RetrievalResultContent;
const RetrievalResultLocation = @import("retrieval_result_location.zig").RetrievalResultLocation;

/// Contains metadata about a source cited for the generated response.
///
/// This data type is used in the following API operations:
///
/// * [RetrieveAndGenerate
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_ResponseSyntax) – in the `retrievedReferences` field
/// * [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax) – in the `retrievedReferences` field
pub const RetrievedReference = struct {
    /// Contains the cited text from the data source.
    content: ?RetrievalResultContent = null,

    /// Contains information about the location of the data source.
    location: ?RetrievalResultLocation = null,

    /// Contains metadata attributes and their values for the file in the data
    /// source. For more information, see [Metadata and
    /// filtering](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-ds.html#kb-ds-metadata).
    metadata: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .content = "content",
        .location = "location",
        .metadata = "metadata",
    };
};
