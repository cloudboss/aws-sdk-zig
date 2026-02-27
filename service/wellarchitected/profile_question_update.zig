/// An update to a profile question.
pub const ProfileQuestionUpdate = struct {
    question_id: ?[]const u8,

    /// The selected choices.
    selected_choice_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .question_id = "QuestionId",
        .selected_choice_ids = "SelectedChoiceIds",
    };
};
