/// Revenue statistics for a single content path, including the path, revenue
/// amount, and request count.
pub const RevenuePathStatistics = struct {
    /// The total revenue amount from this path in the specified currency.
    amount: []const u8,

    /// The URI path.
    path: []const u8,

    /// The percentage of total revenue from this path.
    percentage: f64 = 0,

    /// The number of monetized requests to this path.
    request_count: i64 = 0,

    pub const json_field_names = .{
        .amount = "Amount",
        .path = "Path",
        .percentage = "Percentage",
        .request_count = "RequestCount",
    };
};
