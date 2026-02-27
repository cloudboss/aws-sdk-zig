const FeaturedResultsSetStatus = @import("featured_results_set_status.zig").FeaturedResultsSetStatus;

/// Summary information for a set of featured results. Featured results are
/// placed
/// above all other results for certain queries. If there's an exact match of a
/// query,
/// then one or more specific documents are featured in the search results.
pub const FeaturedResultsSetSummary = struct {
    /// The Unix timestamp when the set of featured results was created.
    creation_timestamp: ?i64,

    /// The identifier of the set of featured results.
    featured_results_set_id: ?[]const u8,

    /// The name for the set of featured results.
    featured_results_set_name: ?[]const u8,

    /// The Unix timestamp when the set of featured results was last updated.
    last_updated_timestamp: ?i64,

    /// The current status of the set of featured results. When the value is
    /// `ACTIVE`, featured results are ready for use. You can still
    /// configure your settings before setting the status to `ACTIVE`.
    /// You can set the status to `ACTIVE` or `INACTIVE`
    /// using the
    /// [UpdateFeaturedResultsSet](https://docs.aws.amazon.com/kendra/latest/dg/API_UpdateFeaturedResultsSet.html) API. The queries you specify for
    /// featured results must be unique per featured results set for each index,
    /// whether the status is `ACTIVE` or `INACTIVE`.
    status: ?FeaturedResultsSetStatus,

    pub const json_field_names = .{
        .creation_timestamp = "CreationTimestamp",
        .featured_results_set_id = "FeaturedResultsSetId",
        .featured_results_set_name = "FeaturedResultsSetName",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .status = "Status",
    };
};
