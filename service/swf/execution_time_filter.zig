/// Used to filter the workflow executions in visibility APIs by various
/// time-based rules. Each parameter, if
/// specified, defines a rule that must be satisfied by each returned query
/// result. The parameter values are in the [Unix Time
/// format](https://en.wikipedia.org/wiki/Unix_time). For example:
/// `"oldestDate": 1325376070.`
pub const ExecutionTimeFilter = struct {
    /// Specifies the latest start or close date and time to return.
    latest_date: ?i64 = null,

    /// Specifies the oldest start or close date and time to return.
    oldest_date: i64,

    pub const json_field_names = .{
        .latest_date = "latestDate",
        .oldest_date = "oldestDate",
    };
};
