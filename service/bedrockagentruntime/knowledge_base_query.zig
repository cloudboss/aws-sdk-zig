const InputImage = @import("input_image.zig").InputImage;
const KnowledgeBaseQueryType = @import("knowledge_base_query_type.zig").KnowledgeBaseQueryType;

/// Contains the query made to the knowledge base.
///
/// This data type is used in the following API operations:
///
/// * [Retrieve
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Retrieve.html#API_agent-runtime_Retrieve_RequestSyntax) – in the `retrievalQuery` field
pub const KnowledgeBaseQuery = struct {
    /// An image to include in the knowledge base query for multimodal retrieval.
    image: ?InputImage = null,

    /// The text of the query made to the knowledge base.
    text: []const u8 = "",

    /// The type of query being performed.
    @"type": KnowledgeBaseQueryType = "TEXT",

    pub const json_field_names = .{
        .image = "image",
        .text = "text",
        .@"type" = "type",
    };
};
