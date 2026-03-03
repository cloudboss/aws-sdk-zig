const FeaturedDocument = @import("featured_document.zig").FeaturedDocument;
const FeaturedResultsSetStatus = @import("featured_results_set_status.zig").FeaturedResultsSetStatus;

/// A set of featured results that are displayed at the top of your search
/// results.
/// Featured results are placed above all other results for certain queries. If
/// there's
/// an exact match of a query, then one or more specific documents are featured
/// in the
/// search results.
pub const FeaturedResultsSet = struct {
    /// The Unix timestamp when the set of featured results was created.
    creation_timestamp: ?i64 = null,

    /// The description for the set of featured results.
    description: ?[]const u8 = null,

    /// The list of document IDs for the documents you want to feature at the
    /// top of the search results page. You can use the
    /// [Query](https://docs.aws.amazon.com/kendra/latest/dg/API_Query.html) API to
    /// search for
    /// specific documents with their document IDs included in the result items,
    /// or you can use the console.
    ///
    /// You can add up to four featured documents. You can request to increase this
    /// limit by contacting [Support](http://aws.amazon.com/contact-us/).
    ///
    /// Specific queries are mapped to specific documents for featuring in the
    /// results. If a query contains an exact match, then one or more specific
    /// documents are featured in the results. The exact match applies to the full
    /// query. For example, if you only specify 'Kendra', queries such as 'How does
    /// kendra semantically rank results?' will not render the featured results.
    /// Featured results are designed for specific queries, rather than queries
    /// that are too broad in scope.
    featured_documents: ?[]const FeaturedDocument = null,

    /// The identifier of the set of featured results.
    featured_results_set_id: ?[]const u8 = null,

    /// The name for the set of featured results.
    featured_results_set_name: ?[]const u8 = null,

    /// The Unix timestamp when the set of featured results was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The list of queries for featuring results.
    ///
    /// Specific queries are mapped to specific documents for featuring in
    /// the results. If a query contains an exact match, then one or more
    /// specific documents are featured in the results. The exact match applies
    /// to the full query. For example, if you only specify 'Kendra', queries
    /// such as 'How does kendra semantically rank results?' will not render the
    /// featured results. Featured results are designed for specific queries,
    /// rather than queries that are too broad in scope.
    query_texts: ?[]const []const u8 = null,

    /// The current status of the set of featured results. When the value is
    /// `ACTIVE`, featured results are ready for use. You can still
    /// configure your settings before setting the status to `ACTIVE`.
    /// You can set the status to `ACTIVE` or `INACTIVE`
    /// using the
    /// [UpdateFeaturedResultsSet](https://docs.aws.amazon.com/kendra/latest/dg/API_UpdateFeaturedResultsSet.html) API. The queries you specify for
    /// featured results must be unique per featured results set for each index,
    /// whether the status is `ACTIVE` or `INACTIVE`.
    status: ?FeaturedResultsSetStatus = null,

    pub const json_field_names = .{
        .creation_timestamp = "CreationTimestamp",
        .description = "Description",
        .featured_documents = "FeaturedDocuments",
        .featured_results_set_id = "FeaturedResultsSetId",
        .featured_results_set_name = "FeaturedResultsSetName",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .query_texts = "QueryTexts",
        .status = "Status",
    };
};
