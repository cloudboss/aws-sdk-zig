/// A featured document. This document is displayed at the top of the search
/// results page, placed above all other results for certain queries. If there's
/// an exact match of a query, then the document is featured in the search
/// results.
pub const FeaturedDocument = struct {
    /// The identifier of the document to feature in the search results. You can
    /// use the [Query](https://docs.aws.amazon.com/kendra/latest/dg/API_Query.html)
    /// API to search for
    /// specific documents with their document IDs included in the result items,
    /// or you can use the console.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};
