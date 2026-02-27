/// Contains the names of the fields used for an exact response to the user.
pub const ExactResponseFields = struct {
    /// The name of the field that contains the answer to the query made to the
    /// OpenSearch Service database.
    answer_field: []const u8,

    /// The name of the field that contains the query made to the OpenSearch Service
    /// database.
    question_field: []const u8,

    pub const json_field_names = .{
        .answer_field = "answerField",
        .question_field = "questionField",
    };
};
