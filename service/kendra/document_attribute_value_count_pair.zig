const DocumentAttributeValue = @import("document_attribute_value.zig").DocumentAttributeValue;
const FacetResult = @import("facet_result.zig").FacetResult;

/// Provides the count of documents that match a particular document attribute
/// or field when
/// doing a faceted search.
pub const DocumentAttributeValueCountPair = struct {
    /// The number of documents in the response that have the attribute/field value
    /// for the
    /// key.
    count: ?i32,

    /// The value of the attribute/field. For example, "HR".
    document_attribute_value: ?DocumentAttributeValue,

    /// Contains the results of a document attribute/field that is a nested facet. A
    /// `FacetResult` contains the counts for each facet nested within a
    /// facet.
    ///
    /// For example, the document attribute or facet "Department" includes a value
    /// called
    /// "Engineering". In addition, the document attribute or facet "SubDepartment"
    /// includes the
    /// values "Frontend" and "Backend" for documents assigned to "Engineering". You
    /// can display
    /// nested facets in the search results so that documents can be searched not
    /// only by
    /// department but also by a sub department within a department. The counts for
    /// documents that
    /// belong to "Frontend" and "Backend" within "Engineering" are returned for a
    /// query.
    facet_results: ?[]const FacetResult,

    pub const json_field_names = .{
        .count = "Count",
        .document_attribute_value = "DocumentAttributeValue",
        .facet_results = "FacetResults",
    };
};
