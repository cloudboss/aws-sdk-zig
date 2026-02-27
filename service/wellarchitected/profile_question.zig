const ProfileChoice = @import("profile_choice.zig").ProfileChoice;

/// A profile question.
pub const ProfileQuestion = struct {
    /// The maximum number of selected choices.
    max_selected_choices: ?i32,

    /// The minimum number of selected choices.
    min_selected_choices: ?i32,

    /// The question choices.
    question_choices: ?[]const ProfileChoice,

    question_description: ?[]const u8,

    question_id: ?[]const u8,

    question_title: ?[]const u8,

    /// The selected choices.
    selected_choice_ids: ?[]const []const u8,

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
