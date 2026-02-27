const GroupingIdentifier = @import("grouping_identifier.zig").GroupingIdentifier;

/// Contains an aggregate summary of log groups grouped by data source
/// characteristics,
/// including the count of log groups and their grouping identifiers.
pub const AggregateLogGroupSummary = struct {
    /// An array of key-value pairs that identify the data source characteristics
    /// used to group
    /// the log groups.
    ///
    /// The size and content of this array depends on the `groupBy` parameter
    /// specified
    /// in the request.
    grouping_identifiers: ?[]const GroupingIdentifier,

    /// The number of log groups in this aggregate summary group.
    log_group_count: ?i32,

    pub const json_field_names = .{
        .grouping_identifiers = "groupingIdentifiers",
        .log_group_count = "logGroupCount",
    };
};
