/// Information about each finding type associated with the
/// `groupedByFindingType` statistics.
pub const FindingTypeStatistics = struct {
    /// Name of the finding type.
    finding_type: ?[]const u8 = null,

    /// The timestamp at which this finding type was last generated in your
    /// environment.
    last_generated_at: ?i64 = null,

    /// The total number of findings associated with generated for each distinct
    /// finding type.
    total_findings: ?i32 = null,

    pub const json_field_names = .{
        .finding_type = "FindingType",
        .last_generated_at = "LastGeneratedAt",
        .total_findings = "TotalFindings",
    };
};
