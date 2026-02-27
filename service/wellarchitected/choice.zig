const AdditionalResources = @import("additional_resources.zig").AdditionalResources;
const ChoiceContent = @import("choice_content.zig").ChoiceContent;

/// A choice available to answer question.
pub const Choice = struct {
    /// The additional resources for a choice in a custom lens.
    ///
    /// A choice can have up to two additional resources: one of type
    /// `HELPFUL_RESOURCE`,
    /// one of type `IMPROVEMENT_PLAN`, or both.
    additional_resources: ?[]const AdditionalResources,

    choice_id: ?[]const u8,

    description: ?[]const u8,

    /// The helpful resource (both text and URL) for a particular choice.
    ///
    /// This field only applies to custom lenses. Each choice can have only one
    /// helpful resource.
    helpful_resource: ?ChoiceContent,

    /// The improvement plan (both text and URL) for a particular choice.
    ///
    /// This field only applies to custom lenses. Each choice can have only one
    /// improvement plan.
    improvement_plan: ?ChoiceContent,

    title: ?[]const u8,

    pub const json_field_names = .{
        .additional_resources = "AdditionalResources",
        .choice_id = "ChoiceId",
        .description = "Description",
        .helpful_resource = "HelpfulResource",
        .improvement_plan = "ImprovementPlan",
        .title = "Title",
    };
};
