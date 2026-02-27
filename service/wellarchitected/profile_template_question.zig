const ProfileTemplateChoice = @import("profile_template_choice.zig").ProfileTemplateChoice;

/// A profile template question.
pub const ProfileTemplateQuestion = struct {
    /// The maximum number of choices selected.
    max_selected_choices: ?i32,

    /// The minimum number of choices selected.
    min_selected_choices: ?i32,

    /// The question choices.
    question_choices: ?[]const ProfileTemplateChoice,

    question_description: ?[]const u8,

    question_id: ?[]const u8,

    question_title: ?[]const u8,

    pub const json_field_names = .{
        .max_selected_choices = "MaxSelectedChoices",
        .min_selected_choices = "MinSelectedChoices",
        .question_choices = "QuestionChoices",
        .question_description = "QuestionDescription",
        .question_id = "QuestionId",
        .question_title = "QuestionTitle",
    };
};
