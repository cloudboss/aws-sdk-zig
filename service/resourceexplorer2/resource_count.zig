/// Information about the number of results that match the query. At this time,
/// Amazon Web Services Resource Explorer doesn't count more than 1,000 matches
/// for any query. This structure provides information about whether the query
/// exceeded this limit.
///
/// This field is included in every page when you paginate the results.
pub const ResourceCount = struct {
    /// Indicates whether the `TotalResources` value represents an exhaustive count
    /// of search results.
    ///
    /// * If `True`, it indicates that the search was exhaustive. Every resource
    ///   that matches the query was counted.
    /// * If `False`, then the search reached the limit of 1,000 matching results,
    ///   and stopped counting.
    complete: ?bool = null,

    /// The number of resources that match the search query. This value can't exceed
    /// 1,000. If there are more than 1,000 resources that match the query, then
    /// only 1,000 are counted and the `Complete` field is set to false. We
    /// recommend that you refine your query to return a smaller number of results.
    total_resources: ?i64 = null,

    pub const json_field_names = .{
        .complete = "Complete",
        .total_resources = "TotalResources",
    };
};
