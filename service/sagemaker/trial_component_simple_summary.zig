const UserContext = @import("user_context.zig").UserContext;
const TrialComponentSource = @import("trial_component_source.zig").TrialComponentSource;

/// A short summary of a trial component.
pub const TrialComponentSimpleSummary = struct {
    created_by: ?UserContext,

    /// When the component was created.
    creation_time: ?i64,

    /// The Amazon Resource Name (ARN) of the trial component.
    trial_component_arn: ?[]const u8,

    /// The name of the trial component.
    trial_component_name: ?[]const u8,

    trial_component_source: ?TrialComponentSource,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .trial_component_arn = "TrialComponentArn",
        .trial_component_name = "TrialComponentName",
        .trial_component_source = "TrialComponentSource",
    };
};
