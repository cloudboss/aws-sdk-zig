const Citation = @import("citation.zig").Citation;
const GeneratedResponsePart = @import("generated_response_part.zig").GeneratedResponsePart;
const RetrievedReference = @import("retrieved_reference.zig").RetrievedReference;

/// A citation event.
pub const CitationEvent = struct {
    /// The citation.
    citation: ?Citation = null,

    /// The generated response to the citation event.
    generated_response_part: ?GeneratedResponsePart = null,

    /// The retrieved references of the citation event.
    retrieved_references: ?[]const RetrievedReference = null,

    pub const json_field_names = .{
        .citation = "citation",
        .generated_response_part = "generatedResponsePart",
        .retrieved_references = "retrievedReferences",
    };
};
