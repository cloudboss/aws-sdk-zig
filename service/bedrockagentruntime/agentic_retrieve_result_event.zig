const AgenticRetrieveGeneratedResponse = @import("agentic_retrieve_generated_response.zig").AgenticRetrieveGeneratedResponse;
const AgenticRetrieveResultItem = @import("agentic_retrieve_result_item.zig").AgenticRetrieveResultItem;

/// An event containing agentic retrieval results.
pub const AgenticRetrieveResultEvent = struct {
    /// The generated response. Present only when generateResponse is true.
    generated_response: ?AgenticRetrieveGeneratedResponse = null,

    /// Opaque continuation token for paginated results.
    next_token: ?[]const u8 = null,

    /// The list of retrieved result items.
    results: []const AgenticRetrieveResultItem,

    pub const json_field_names = .{
        .generated_response = "generatedResponse",
        .next_token = "nextToken",
        .results = "results",
    };
};
