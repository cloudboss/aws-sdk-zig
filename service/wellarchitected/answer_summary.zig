const ChoiceAnswerSummary = @import("choice_answer_summary.zig").ChoiceAnswerSummary;
const Choice = @import("choice.zig").Choice;
const JiraConfiguration = @import("jira_configuration.zig").JiraConfiguration;
const QuestionType = @import("question_type.zig").QuestionType;
const AnswerReason = @import("answer_reason.zig").AnswerReason;
const Risk = @import("risk.zig").Risk;

/// An answer summary of a lens review in a workload.
pub const AnswerSummary = struct {
    /// A list of selected choices to a question in your workload.
    choice_answer_summaries: ?[]const ChoiceAnswerSummary,

    choices: ?[]const Choice,

    is_applicable: ?bool,

    /// Configuration of the Jira integration.
    jira_configuration: ?JiraConfiguration,

    pillar_id: ?[]const u8,

    question_id: ?[]const u8,

    question_title: ?[]const u8,

    /// The type of the question.
    question_type: ?QuestionType,

    /// The reason why a choice is non-applicable to a question in your workload.
    reason: ?AnswerReason,

    risk: ?Risk,

    selected_choices: ?[]const []const u8,

    pub const json_field_names = .{
        .choice_answer_summaries = "ChoiceAnswerSummaries",
        .choices = "Choices",
        .is_applicable = "IsApplicable",
        .jira_configuration = "JiraConfiguration",
        .pillar_id = "PillarId",
        .question_id = "QuestionId",
        .question_title = "QuestionTitle",
        .question_type = "QuestionType",
        .reason = "Reason",
        .risk = "Risk",
        .selected_choices = "SelectedChoices",
    };
};
