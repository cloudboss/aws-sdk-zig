const ReferenceType = @import("reference_type.zig").ReferenceType;

/// A single result from a content retrieval operation.
pub const RetrieveResult = struct {
    /// The identifier of the assistant association for the retrieved result.
    association_id: []const u8,

    /// The text content of the retrieved result.
    content_text: []const u8,

    /// A type to define the KB origin of a retrieved content.
    reference_type: ReferenceType,

    /// The URL, URI, or ID of the retrieved content when available, or a UUID when
    /// unavailable.
    source_id: []const u8,

    pub const json_field_names = .{
        .association_id = "associationId",
        .content_text = "contentText",
        .reference_type = "referenceType",
        .source_id = "sourceId",
    };
};
