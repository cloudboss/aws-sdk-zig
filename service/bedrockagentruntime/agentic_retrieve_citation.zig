const AgenticRetrieveCitationReference = @import("agentic_retrieve_citation_reference.zig").AgenticRetrieveCitationReference;

/// A citation mapping a span of the generated answer to supporting results.
pub const AgenticRetrieveCitation = struct {
    /// Character offset end (exclusive) in the answer text.
    end_index: i32,

    /// References to results that support this span.
    references: []const AgenticRetrieveCitationReference,

    /// Character offset start in the answer text.
    start_index: i32,

    pub const json_field_names = .{
        .end_index = "endIndex",
        .references = "references",
        .start_index = "startIndex",
    };
};
