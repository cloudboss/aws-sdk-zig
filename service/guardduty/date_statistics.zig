/// Represents list a map of dates with a count of total findings generated on
/// each date.
pub const DateStatistics = struct {
    /// The timestamp when the total findings count is observed.
    ///
    /// For example, `Date` would look like `"2024-09-05T17:00:00-07:00"`
    /// whereas `LastGeneratedAt` would look like 2024-09-05T17:12:29-07:00".
    date: ?i64,

    /// The timestamp at which the last finding in the findings count, was
    /// generated.
    last_generated_at: ?i64,

    /// The severity of the findings generated on each date.
    severity: ?f64,

    /// The total number of findings that were generated per severity level on each
    /// date.
    total_findings: ?i32,

    pub const json_field_names = .{
        .date = "Date",
        .last_generated_at = "LastGeneratedAt",
        .severity = "Severity",
        .total_findings = "TotalFindings",
    };
};
