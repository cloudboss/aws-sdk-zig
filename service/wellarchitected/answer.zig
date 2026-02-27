const ChoiceAnswer = @import("choice_answer.zig").ChoiceAnswer;
const Choice = @import("choice.zig").Choice;
const JiraConfiguration = @import("jira_configuration.zig").JiraConfiguration;
const AnswerReason = @import("answer_reason.zig").AnswerReason;
const Risk = @import("risk.zig").Risk;

/// An answer of the question.
pub const Answer = struct {
    /// A list of selected choices to a question in your workload.
    choice_answers: ?[]const ChoiceAnswer,

    choices: ?[]const Choice,

    /// The helpful resource text to be displayed for a custom lens.
    ///
    /// This field does not apply to Amazon Web Services official lenses.
    helpful_resource_display_text: ?[]const u8,

    helpful_resource_url: ?[]const u8,

    improvement_plan_url: ?[]const u8,

    is_applicable: ?bool,

    /// Configuration of the Jira integration.
    jira_configuration: ?JiraConfiguration,

    notes: ?[]const u8,

    pillar_id: ?[]const u8,

    question_description: ?[]const u8,

    question_id: ?[]const u8,

    question_title: ?[]const u8,

    /// The reason why the question is not applicable to your workload.
    reason: ?AnswerReason,

    risk: ?Risk,

    selected_choices: ?[]const []const u8,

    pub const json_field_names = .{
        .choice_answers = "ChoiceAnswers",
        .choices = "Choices",
        .helpful_resource_display_text = "HelpfulResourceDisplayText",
        .helpful_resource_url = "HelpfulResourceUrl",
        .improvement_plan_url = "ImprovementPlanUrl",
        .is_applicable = "IsApplicable",
        .jira_configuration = "JiraConfiguration",
        .notes = "Notes",
        .pillar_id = "PillarId",
        .question_description = "QuestionDescription",
        .question_id = "QuestionId",
        .question_title = "QuestionTitle",
        .reason = "Reason",
        .risk = "Risk",
        .selected_choices = "SelectedChoices",
    };
};
