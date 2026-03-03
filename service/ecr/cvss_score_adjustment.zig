/// Details on adjustments Amazon Inspector made to the CVSS score for a
/// finding.
pub const CvssScoreAdjustment = struct {
    /// The metric used to adjust the CVSS score.
    metric: ?[]const u8 = null,

    /// The reason the CVSS score has been adjustment.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric = "metric",
        .reason = "reason",
    };
};
