/// Specifies the time range for filtering insights.
pub const InsightTimeRange = struct {
    /// The start of the time range, in epoch milliseconds.
    from: i64,

    /// The end of the time range, in epoch milliseconds.
    to: i64,

    pub const json_field_names = .{
        .from = "From",
        .to = "To",
    };
};
