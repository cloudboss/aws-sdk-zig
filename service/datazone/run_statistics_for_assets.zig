/// The asset statistics from the data source run.
pub const RunStatisticsForAssets = struct {
    /// The `added` statistic for the data source run.
    added: ?i32 = null,

    /// The `failed` statistic for the data source run.
    failed: ?i32 = null,

    /// The `skipped` statistic for the data source run.
    skipped: ?i32 = null,

    /// The `unchanged` statistic for the data source run.
    unchanged: ?i32 = null,

    /// The `updated` statistic for the data source run.
    updated: ?i32 = null,

    pub const json_field_names = .{
        .added = "added",
        .failed = "failed",
        .skipped = "skipped",
        .unchanged = "unchanged",
        .updated = "updated",
    };
};
