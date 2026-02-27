/// The choice level improvement plan.
pub const ChoiceImprovementPlan = struct {
    choice_id: ?[]const u8,

    /// The display text for the improvement plan.
    display_text: ?[]const u8,

    improvement_plan_url: ?[]const u8,

    pub const json_field_names = .{
        .choice_id = "ChoiceId",
        .display_text = "DisplayText",
        .improvement_plan_url = "ImprovementPlanUrl",
    };
};
