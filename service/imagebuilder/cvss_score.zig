/// A CVSS score for the vulnerability, as published by the vulnerability
/// source. Sources include the National Vulnerability Database (NVD) and the
/// operating system vendor's security feed. A finding can include CVSS scores
/// from multiple sources and CVSS versions.
pub const CvssScore = struct {
    /// The CVSS base score.
    base_score: ?f64 = null,

    /// The vector string of the CVSS score.
    scoring_vector: ?[]const u8 = null,

    /// The source of the CVSS score.
    source: ?[]const u8 = null,

    /// The CVSS version that generated the score.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_score = "baseScore",
        .scoring_vector = "scoringVector",
        .source = "source",
        .version = "version",
    };
};
