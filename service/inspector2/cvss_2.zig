/// The Common Vulnerability Scoring System (CVSS) version 2 details for the
/// vulnerability.
pub const Cvss2 = struct {
    /// The CVSS v2 base score for the vulnerability.
    base_score: f64 = 0,

    /// The scoring vector associated with the CVSS v2 score.
    scoring_vector: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_score = "baseScore",
        .scoring_vector = "scoringVector",
    };
};
