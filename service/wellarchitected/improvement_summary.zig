const ChoiceImprovementPlan = @import("choice_improvement_plan.zig").ChoiceImprovementPlan;
const JiraConfiguration = @import("jira_configuration.zig").JiraConfiguration;
const Risk = @import("risk.zig").Risk;

/// An improvement summary of a lens review in a workload.
pub const ImprovementSummary = struct {
    /// The improvement plan details.
    improvement_plans: ?[]const ChoiceImprovementPlan = null,

    improvement_plan_url: ?[]const u8 = null,

    /// Configuration of the Jira integration.
    jira_configuration: ?JiraConfiguration = null,

    pillar_id: ?[]const u8 = null,

    question_id: ?[]const u8 = null,

    question_title: ?[]const u8 = null,

    risk: ?Risk = null,

    pub const json_field_names = .{
        .improvement_plans = "ImprovementPlans",
        .improvement_plan_url = "ImprovementPlanUrl",
        .jira_configuration = "JiraConfiguration",
        .pillar_id = "PillarId",
        .question_id = "QuestionId",
        .question_title = "QuestionTitle",
        .risk = "Risk",
    };
};
