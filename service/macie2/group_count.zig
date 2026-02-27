/// Provides a group of results for a query that retrieved aggregated
/// statistical data about findings.
pub const GroupCount = struct {
    /// The total number of findings in the group of query results.
    count: ?i64,

    /// The name of the property that defines the group in the query results, as
    /// specified by the groupBy property in the query request.
    group_key: ?[]const u8,

    pub const json_field_names = .{
        .count = "count",
        .group_key = "groupKey",
    };
};
