const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;

/// The document ID and its fields/attributes that are used for a query
/// suggestion, if
/// document fields set to use for query suggestions.
pub const SourceDocument = struct {
    /// The additional fields/attributes to include in the response. You can use
    /// additional
    /// fields to provide extra information in the response. Additional fields are
    /// not used
    /// to based suggestions on.
    additional_attributes: ?[]const DocumentAttribute,

    /// The identifier of the document used for a query suggestion.
    document_id: ?[]const u8,

    /// The document fields/attributes used for a query suggestion.
    suggestion_attributes: ?[]const []const u8,

    pub const json_field_names = .{
        .additional_attributes = "AdditionalAttributes",
        .document_id = "DocumentId",
        .suggestion_attributes = "SuggestionAttributes",
    };
};
