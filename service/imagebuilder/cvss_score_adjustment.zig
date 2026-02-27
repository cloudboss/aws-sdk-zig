/// Details about an adjustment that Amazon Inspector made to the CVSS score for
/// a finding.
pub const CvssScoreAdjustment = struct {
    /// The metric that Amazon Inspector used to adjust the CVSS score.
    metric: ?[]const u8,

    /// The reason for the CVSS score adjustment.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .metric = "metric",
        .reason = "reason",
    };
};
