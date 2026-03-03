const CvssScoreAdjustment = @import("cvss_score_adjustment.zig").CvssScoreAdjustment;

/// Information about the CVSS score.
pub const CvssScoreDetails = struct {
    /// An object that contains details about adjustment Amazon Inspector made to
    /// the CVSS score.
    adjustments: ?[]const CvssScoreAdjustment = null,

    /// The CVSS score.
    score: f64 = 0,

    /// The source for the CVSS score.
    score_source: ?[]const u8 = null,

    /// The vector for the CVSS score.
    scoring_vector: ?[]const u8 = null,

    /// The CVSS version used in scoring.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .adjustments = "adjustments",
        .score = "score",
        .score_source = "scoreSource",
        .scoring_vector = "scoringVector",
        .version = "version",
    };
};
