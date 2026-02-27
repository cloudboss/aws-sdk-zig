const ComponentMatchScores = @import("component_match_scores.zig").ComponentMatchScores;

/// Details related to the match score.
pub const MatchScoreDetails = struct {
    /// Indicates how well the component input matches the returned. It is equal to
    /// 1 if all input tokens are recognized and matched.
    components: ?ComponentMatchScores,

    /// Indicates how well the entire input matches the returned. It is equal to 1
    /// if all input tokens are recognized and matched.
    overall: f64 = 0,

    pub const json_field_names = .{
        .components = "Components",
        .overall = "Overall",
    };
};
