const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;
const ExpandedResultItem = @import("expanded_result_item.zig").ExpandedResultItem;

/// Provides details about a collapsed group of search results.
pub const CollapsedResultDetail = struct {
    /// The value of the document attribute that results are collapsed on.
    document_attribute: DocumentAttribute,

    /// A list of results in the collapsed group.
    expanded_results: ?[]const ExpandedResultItem,

    pub const json_field_names = .{
        .document_attribute = "DocumentAttribute",
        .expanded_results = "ExpandedResults",
    };
};
