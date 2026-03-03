const ProfileChoice = @import("profile_choice.zig").ProfileChoice;

/// A profile question.
pub const ProfileQuestion = struct {
    /// The maximum number of selected choices.
    max_selected_choices: ?i32 = null,

    /// The minimum number of selected choices.
    min_selected_choices: ?i32 = null,

    /// The question choices.
    question_choices: ?[]const ProfileChoice = null,

    question_description: ?[]const u8 = null,

    question_id: ?[]const u8 = null,

    question_title: ?[]const u8 = null,

    /// The selected choices.
    selected_choice_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .max_selected_choices = "MaxSelectedChoices",
        .min_selected_choices = "MinSelectedChoices",
        .question_choices = "QuestionChoices",
        .question_description = "QuestionDescription",
        .question_id = "QuestionId",
        .question_title = "QuestionTitle",
        .selected_choice_ids = "SelectedChoiceIds",
    };
};
