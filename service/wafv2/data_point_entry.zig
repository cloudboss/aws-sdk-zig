/// A single data point in a revenue time series, representing aggregated
/// monetization metrics for a specific time interval.
pub const DataPointEntry = struct {
    /// The bot category for this data point, when grouped by category.
    category: ?[]const u8 = null,

    /// The timestamp for this data point.
    date: ?i64 = null,

    /// The group-by dimension value for this data point.
    group_by_value: ?[]const u8 = null,

    /// The intent classification for this data point, when grouped by intent.
    intent: ?[]const u8 = null,

    /// The number of HTTP 402 Payment Required responses served during this
    /// interval.
    monetize_served_count: i64 = 0,

    /// The number of successfully settled payments during this interval.
    settled_count: i64 = 0,

    /// The total revenue amount during this interval in the specified currency.
    total_amount: ?[]const u8 = null,

    pub const json_field_names = .{
        .category = "Category",
        .date = "Date",
        .group_by_value = "GroupByValue",
        .intent = "Intent",
        .monetize_served_count = "MonetizeServedCount",
        .settled_count = "SettledCount",
        .total_amount = "TotalAmount",
    };
};
