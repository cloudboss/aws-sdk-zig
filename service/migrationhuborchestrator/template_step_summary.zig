const Owner = @import("owner.zig").Owner;
const StepActionType = @import("step_action_type.zig").StepActionType;
const TargetType = @import("target_type.zig").TargetType;

/// The summary of the step.
pub const TemplateStepSummary = struct {
    /// The ID of the step.
    id: ?[]const u8 = null,

    /// The name of the step.
    name: ?[]const u8 = null,

    /// The next step.
    next: ?[]const []const u8 = null,

    /// The owner of the step.
    owner: ?Owner = null,

    /// The previous step.
    previous: ?[]const []const u8 = null,

    /// The action type of the step. You must run and update the status of a manual
    /// step for
    /// the workflow to continue after the completion of the step.
    step_action_type: ?StepActionType = null,

    /// The ID of the step group.
    step_group_id: ?[]const u8 = null,

    /// The servers on which to run the script.
    target_type: ?TargetType = null,

    /// The ID of the template.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .next = "next",
        .owner = "owner",
        .previous = "previous",
        .step_action_type = "stepActionType",
        .step_group_id = "stepGroupId",
        .target_type = "targetType",
        .template_id = "templateId",
    };
};
