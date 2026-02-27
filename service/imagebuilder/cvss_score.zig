/// Amazon Inspector generates a risk score for each finding. This score helps
/// you to prioritize
/// findings, to focus on the most critical findings and the most vulnerable
/// resources. The
/// score uses the Common Vulnerability Scoring System (CVSS) format. This
/// format is a
/// modification of the base CVSS score that the National Vulnerability Database
/// (NVD)
/// provides. For more information about severity levels, see [Severity levels
/// for Amazon Inspector
/// findings](https://docs.aws.amazon.com/inspector/latest/user/findings-understanding-severity.html) in the *Amazon Inspector User
/// Guide*.
pub const CvssScore = struct {
    /// The CVSS base score.
    base_score: ?f64,

    /// The vector string of the CVSS score.
    scoring_vector: ?[]const u8,

    /// The source of the CVSS score.
    source: ?[]const u8,

    /// The CVSS version that generated the score.
    version: ?[]const u8,

    pub const json_field_names = .{
        .base_score = "baseScore",
        .scoring_vector = "scoringVector",
        .source = "source",
        .version = "version",
    };
};
