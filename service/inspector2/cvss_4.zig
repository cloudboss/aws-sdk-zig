/// The Common Vulnerability Scoring System (CVSS) version 4 details for the
/// vulnerability.
pub const Cvss4 = struct {
    /// The base CVSS v4 score for the vulnerability finding, which rates the
    /// severity of the vulnerability on a scale from 0 to 10.
    base_score: f64 = 0,

    /// The CVSS v4 scoring vector, which contains the metrics and measurements that
    /// were used to calculate the base score.
    scoring_vector: ?[]const u8,

    pub const json_field_names = .{
        .base_score = "baseScore",
        .scoring_vector = "scoringVector",
    };
};
