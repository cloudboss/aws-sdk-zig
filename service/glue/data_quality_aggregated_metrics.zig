/// A summary of metrics showing the total counts of processed rows and rules,
/// including their pass/fail statistics based on row-level results.
pub const DataQualityAggregatedMetrics = struct {
    /// The total number of rows that failed one or more data quality rules.
    total_rows_failed: ?f64 = null,

    /// The total number of rows that passed all applicable data quality rules.
    total_rows_passed: ?f64 = null,

    /// The total number of rows that were processed during the data quality
    /// evaluation.
    total_rows_processed: ?f64 = null,

    /// The total number of data quality rules that failed their evaluation
    /// criteria.
    total_rules_failed: ?f64 = null,

    /// The total number of data quality rules that passed their evaluation
    /// criteria.
    total_rules_passed: ?f64 = null,

    /// The total number of data quality rules that were evaluated.
    total_rules_processed: ?f64 = null,

    pub const json_field_names = .{
        .total_rows_failed = "TotalRowsFailed",
        .total_rows_passed = "TotalRowsPassed",
        .total_rows_processed = "TotalRowsProcessed",
        .total_rules_failed = "TotalRulesFailed",
        .total_rules_passed = "TotalRulesPassed",
        .total_rules_processed = "TotalRulesProcessed",
    };
};
