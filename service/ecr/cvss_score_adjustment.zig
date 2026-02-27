/// Details on adjustments Amazon Inspector made to the CVSS score for a
/// finding.
pub const CvssScoreAdjustment = struct {
    /// The metric used to adjust the CVSS score.
    metric: ?[]const u8,

    /// The reason the CVSS score has been adjustment.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .metric = "metric",
        .reason = "reason",
    };
};
