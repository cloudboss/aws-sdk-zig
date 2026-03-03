const ReviewTemplateAnswerStatus = @import("review_template_answer_status.zig").ReviewTemplateAnswerStatus;
const ChoiceAnswer = @import("choice_answer.zig").ChoiceAnswer;
const Choice = @import("choice.zig").Choice;
const AnswerReason = @import("answer_reason.zig").AnswerReason;

/// An answer of the question.
pub const ReviewTemplateAnswer = struct {
    /// The status of whether or not this question has been answered.
    answer_status: ?ReviewTemplateAnswerStatus = null,

    /// A list of selected choices to a question in your review template.
    choice_answers: ?[]const ChoiceAnswer = null,

    choices: ?[]const Choice = null,

    /// The helpful resource text to be displayed for a custom lens.
    ///
    /// This field does not apply to Amazon Web Services official lenses.
    helpful_resource_display_text: ?[]const u8 = null,

    helpful_resource_url: ?[]const u8 = null,

    improvement_plan_url: ?[]const u8 = null,

    is_applicable: ?bool = null,

    notes: ?[]const u8 = null,

    pillar_id: ?[]const u8 = null,

    question_description: ?[]const u8 = null,

    question_id: ?[]const u8 = null,

    question_title: ?[]const u8 = null,

    /// The reason why the question is not applicable to your review template.
    reason: ?AnswerReason = null,

    selected_choices: ?[]const []const u8 = null,

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
