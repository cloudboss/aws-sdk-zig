const Pattern = @import("pattern.zig").Pattern;
const Match = @import("match.zig").Match;

/// A potential improvement that was found from analyzing the profiling data.
pub const Recommendation = struct {
    /// How many different places in the profile graph triggered a match.
    all_matches_count: i32,

    /// How much of the total sample count is potentially affected.
    all_matches_sum: f64,

    /// End time of the profile that was used by this analysis.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    end_time: i64,

    /// The pattern that analysis recognized in the profile to make this
    /// recommendation.
    pattern: Pattern,

    /// The start time of the profile that was used by this analysis.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    start_time: i64,

    /// List of the matches with most impact.
    top_matches: []const Match,

    pub const json_field_names = .{
        .all_matches_count = "allMatchesCount",
        .all_matches_sum = "allMatchesSum",
        .end_time = "endTime",
        .pattern = "pattern",
        .start_time = "startTime",
        .top_matches = "topMatches",
    };
};
