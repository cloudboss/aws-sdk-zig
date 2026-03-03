/// Provides information about a single utterance that was made to your
/// bot.
pub const UtteranceData = struct {
    /// The number of times that the utterance was processed.
    count: ?i32 = null,

    /// The total number of individuals that used the utterance.
    distinct_users: ?i32 = null,

    /// The date that the utterance was first recorded.
    first_uttered_date: ?i64 = null,

    /// The date that the utterance was last recorded.
    last_uttered_date: ?i64 = null,

    /// The text that was entered by the user or the text representation of
    /// an audio clip.
    utterance_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .count = "count",
        .distinct_users = "distinctUsers",
        .first_uttered_date = "firstUtteredDate",
        .last_uttered_date = "lastUtteredDate",
        .utterance_string = "utteranceString",
    };
};
