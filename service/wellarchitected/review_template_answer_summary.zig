const ReviewTemplateAnswerStatus = @import("review_template_answer_status.zig").ReviewTemplateAnswerStatus;
const ChoiceAnswerSummary = @import("choice_answer_summary.zig").ChoiceAnswerSummary;
const Choice = @import("choice.zig").Choice;
const QuestionType = @import("question_type.zig").QuestionType;
const AnswerReason = @import("answer_reason.zig").AnswerReason;

/// The summary of review template answers.
pub const ReviewTemplateAnswerSummary = struct {
    /// The status of whether or not this question has been answered.
    answer_status: ?ReviewTemplateAnswerStatus = null,

    /// A list of selected choices to a question in the review template.
    choice_answer_summaries: ?[]const ChoiceAnswerSummary = null,

    choices: ?[]const Choice = null,

    is_applicable: ?bool = null,

    pillar_id: ?[]const u8 = null,

    question_id: ?[]const u8 = null,

    question_title: ?[]const u8 = null,

    /// The type of question.
    question_type: ?QuestionType = null,

    /// The reason why a choice is not-applicable to a question in the review
    /// template.
    reason: ?AnswerReason = null,

    selected_choices: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .answer_status = "AnswerStatus",
        .choice_answer_summaries = "ChoiceAnswerSummaries",
        .choices = "Choices",
        .is_applicable = "IsApplicable",
        .pillar_id = "PillarId",
        .question_id = "QuestionId",
        .question_title = "QuestionTitle",
        .question_type = "QuestionType",
        .reason = "Reason",
        .selected_choices = "SelectedChoices",
    };
};
