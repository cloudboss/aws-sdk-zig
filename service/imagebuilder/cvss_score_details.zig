const CvssScoreAdjustment = @import("cvss_score_adjustment.zig").CvssScoreAdjustment;

/// Details about the source of the score, and the factors that determined the
/// adjustments
/// to create the final score.
pub const CvssScoreDetails = struct {
    /// The adjustments that Amazon Inspector applied to the base CVSS score to
    /// produce its own
    /// score for the finding. The list is empty when Amazon Inspector made no
    /// adjustments.
    adjustments: ?[]const CvssScoreAdjustment = null,

    /// The source of the CVSS data that the Amazon Inspector score for the finding
    /// is based
    /// on, for example NVD or a vendor security feed.
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
