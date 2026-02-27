/// Details about the Exploit Prediction Scoring System (EPSS) score for a
/// finding.
pub const EpssDetails = struct {
    /// The EPSS score.
    score: f64 = 0,

    pub const json_field_names = .{
        .score = "score",
    };
};
