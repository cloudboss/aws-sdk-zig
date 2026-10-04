const AgenticRetrieveCitation = @import("agentic_retrieve_citation.zig").AgenticRetrieveCitation;

/// The generated response synthesized from retrieved results.
pub const AgenticRetrieveGeneratedResponse = struct {
    /// The generated answer text.
    answer: []const u8,

    /// Citations mapping spans of the answer to supporting results.
    citations: ?[]const AgenticRetrieveCitation = null,

    pub const json_field_names = .{
        .answer = "answer",
        .citations = "citations",
    };
};
