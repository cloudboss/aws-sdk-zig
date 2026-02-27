/// The asset statistics from the data source run.
pub const RunStatisticsForAssets = struct {
    /// The `added` statistic for the data source run.
    added: ?i32,

    /// The `failed` statistic for the data source run.
    failed: ?i32,

    /// The `skipped` statistic for the data source run.
    skipped: ?i32,

    /// The `unchanged` statistic for the data source run.
    unchanged: ?i32,

    /// The `updated` statistic for the data source run.
    updated: ?i32,

    pub const json_field_names = .{
        .added = "added",
        .failed = "failed",
        .skipped = "skipped",
        .unchanged = "unchanged",
        .updated = "updated",
    };
};
