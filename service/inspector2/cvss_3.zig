/// The Common Vulnerability Scoring System (CVSS) version 3 details for the
/// vulnerability.
pub const Cvss3 = struct {
    /// The CVSS v3 base score for the vulnerability.
    base_score: f64 = 0,

    /// The scoring vector associated with the CVSS v3 score.
    scoring_vector: ?[]const u8,

    pub const json_field_names = .{
        .base_score = "baseScore",
        .scoring_vector = "scoringVector",
    };
};
