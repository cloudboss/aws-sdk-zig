/// Details about the Exploit Prediction Scoring System (EPSS) score.
pub const Epss = struct {
    /// The Exploit Prediction Scoring System (EPSS) score.
    score: f64 = 0,

    pub const json_field_names = .{
        .score = "score",
    };
};
