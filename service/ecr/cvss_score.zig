/// The CVSS score for a finding.
pub const CvssScore = struct {
    /// The base CVSS score used for the finding.
    base_score: f64 = 0,

    /// The vector string of the CVSS score.
    scoring_vector: ?[]const u8 = null,

    /// The source of the CVSS score.
    source: ?[]const u8 = null,

    /// The version of CVSS used for the score.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_score = "baseScore",
        .scoring_vector = "scoringVector",
        .source = "source",
        .version = "version",
    };
};
