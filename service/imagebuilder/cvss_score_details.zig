const CvssScoreAdjustment = @import("cvss_score_adjustment.zig").CvssScoreAdjustment;

/// Details about the source of the score, and the factors that determined the
/// adjustments
/// to create the final score.
pub const CvssScoreDetails = struct {
    /// An object that contains details about an adjustment that Amazon Inspector
    /// made to the CVSS score
    /// for the finding.
    adjustments: ?[]const CvssScoreAdjustment = null,

    /// The source of the finding.
    cvss_source: ?[]const u8 = null,

    /// The CVSS score.
    score: ?f64 = null,

    /// The source for the CVSS score.
    score_source: ?[]const u8 = null,

    /// A vector that measures the severity of the vulnerability.
    scoring_vector: ?[]const u8 = null,

    /// The CVSS version that generated the score.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .adjustments = "adjustments",
        .cvss_source = "cvssSource",
        .score = "score",
        .score_source = "scoreSource",
        .scoring_vector = "scoringVector",
        .version = "version",
    };
};
