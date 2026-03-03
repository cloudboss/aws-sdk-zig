/// This data structure is the data type for the AnswerKey
/// parameter of the ScoreMyKnownAnswers/2011-09-01 Review Policy.
pub const ParameterMapEntry = struct {
    /// The QuestionID from the HIT that is used to identify which
    /// question requires Mechanical Turk to score as part of the
    /// ScoreMyKnownAnswers/2011-09-01 Review Policy.
    key: ?[]const u8 = null,

    /// The list of answers to the question specified in the
    /// MapEntry Key element. The Worker must match all values in order for
    /// the answer to be scored correctly.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
