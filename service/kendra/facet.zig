/// Information about a document attribute or field. You can use document
/// attributes as
/// facets.
///
/// For example, the document attribute or facet "Department" includes the
/// values "HR",
/// "Engineering", and "Accounting". You can display these values in the search
/// results so that
/// documents can be searched by department.
///
/// You can display up to 10 facet values per facet for a query. If you want to
/// increase
/// this limit, contact [Support](http://aws.amazon.com/contact-us/).
pub const Facet = struct {
    /// The unique key for the document attribute.
    document_attribute_key: ?[]const u8,

    /// An array of document attributes that are nested facets within a facet.
    ///
    /// For example, the document attribute or facet "Department" includes a value
    /// called
    /// "Engineering". In addition, the document attribute or facet "SubDepartment"
    /// includes the
    /// values "Frontend" and "Backend" for documents assigned to "Engineering". You
    /// can display
    /// nested facets in the search results so that documents can be searched not
    /// only by
    /// department but also by a sub department within a department. This helps your
    /// users further
    /// narrow their search.
    ///
    /// You can only have one nested facet within a facet. If you want to increase
    /// this limit,
    /// contact [Support](http://aws.amazon.com/contact-us/).
    facets: ?[]const Facet,

    /// Maximum number of facet values per facet. The default is 10. You can use
    /// this to limit
    /// the number of facet values to less than 10. If you want to increase the
    /// default, contact
    /// [Support](http://aws.amazon.com/contact-us/).
    max_results: i32 = 0,

    pub const json_field_names = .{
        .document_attribute_key = "DocumentAttributeKey",
        .facets = "Facets",
        .max_results = "MaxResults",
    };
};
