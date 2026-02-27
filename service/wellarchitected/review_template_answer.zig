const ReviewTemplateAnswerStatus = @import("review_template_answer_status.zig").ReviewTemplateAnswerStatus;
const ChoiceAnswer = @import("choice_answer.zig").ChoiceAnswer;
const Choice = @import("choice.zig").Choice;
const AnswerReason = @import("answer_reason.zig").AnswerReason;

/// An answer of the question.
pub const ReviewTemplateAnswer = struct {
    /// The status of whether or not this question has been answered.
    answer_status: ?ReviewTemplateAnswerStatus,

    /// A list of selected choices to a question in your review template.
    choice_answers: ?[]const ChoiceAnswer,

    choices: ?[]const Choice,

    /// The helpful resource text to be displayed for a custom lens.
    ///
    /// This field does not apply to Amazon Web Services official lenses.
    helpful_resource_display_text: ?[]const u8,

    helpful_resource_url: ?[]const u8,

    improvement_plan_url: ?[]const u8,

    is_applicable: ?bool,

    notes: ?[]const u8,

    pillar_id: ?[]const u8,

    question_description: ?[]const u8,

    question_id: ?[]const u8,

    question_title: ?[]const u8,

    /// The reason why the question is not applicable to your review template.
    reason: ?AnswerReason,

    selected_choices: ?[]const []const u8,

    pub const json_field_names = .{
        .answer_status = "AnswerStatus",
        .choice_answers = "ChoiceAnswers",
        .choices = "Choices",
        .helpful_resource_display_text = "HelpfulResourceDisplayText",
        .helpful_resource_url = "HelpfulResourceUrl",
        .improvement_plan_url = "ImprovementPlanUrl",
        .is_applicable = "IsApplicable",
        .notes = "Notes",
        .pillar_id = "PillarId",
        .question_description = "QuestionDescription",
        .question_id = "QuestionId",
        .question_title = "QuestionTitle",
        .reason = "Reason",
        .selected_choices = "SelectedChoices",
    };
};
