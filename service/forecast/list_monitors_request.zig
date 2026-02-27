const Filter = @import("filter.zig").Filter;

pub const ListMonitorsRequest = struct {
    /// An array of filters. For each filter, provide a condition and a match
    /// statement. The
    /// condition is either `IS` or `IS_NOT`, which specifies whether to
    /// include or exclude the resources that match the statement from the list. The
    /// match
    /// statement consists of a key and a value.
    ///
    /// **Filter properties**
    ///
    /// * `Condition` - The condition to apply. Valid values are
    /// `IS` and `IS_NOT`.
    ///
    /// * `Key` - The name of the parameter to filter on. The only valid value is
    /// `Status`.
    ///
    /// * `Value` - The value to match.
    ///
    /// For example, to list all monitors who's status is ACTIVE, you would specify:
    ///
    /// `"Filters": [ { "Condition": "IS", "Key": "Status", "Value": "ACTIVE" } ]`
    filters: ?[]const Filter,

    /// The maximum number of monitors to include in the response.
    max_results: ?i32,

    /// If the result of the previous request was truncated, the response includes a
    /// `NextToken`. To retrieve the next set of results, use the token in the next
    /// request. Tokens expire after 24 hours.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
