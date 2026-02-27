/// Structure to capture query statistics such as how many queries are running,
/// accepted or waiting and their details.
pub const QueryEvalStats = struct {
    /// Set to `TRUE` if the query was cancelled, or FALSE otherwise.
    cancelled: ?bool,

    /// The number of milliseconds the query has been running so far.
    elapsed: ?i32,

    /// The number of subqueries in this query.
    subqueries: ?[]const u8,

    /// Indicates how long the query waited, in milliseconds.
    waited: ?i32,

    pub const json_field_names = .{
        .cancelled = "cancelled",
        .elapsed = "elapsed",
        .subqueries = "subqueries",
        .waited = "waited",
    };
};
