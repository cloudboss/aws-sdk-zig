/// The summary of the specified search job scope, including:
///
/// * TotalBackupsToScanCount, the number of recovery points returned by the
///   search.
/// * TotalItemsToScanCount, the number of items returned by the search.
pub const SearchScopeSummary = struct {
    /// This is the count of the total number of items that will be scanned in a
    /// search.
    total_items_to_scan_count: ?i64,

    /// This is the count of the total number of backups that will be scanned in a
    /// search.
    total_recovery_points_to_scan_count: ?i32,

    pub const json_field_names = .{
        .total_items_to_scan_count = "TotalItemsToScanCount",
        .total_recovery_points_to_scan_count = "TotalRecoveryPointsToScanCount",
    };
};
