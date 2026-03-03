const UserContext = @import("user_context.zig").UserContext;
const TrialComponentSource = @import("trial_component_source.zig").TrialComponentSource;

/// A short summary of a trial component.
pub const TrialComponentSimpleSummary = struct {
    created_by: ?UserContext = null,

    /// When the component was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the trial component.
    trial_component_arn: ?[]const u8 = null,

    /// The name of the trial component.
    trial_component_name: ?[]const u8 = null,

    trial_component_source: ?TrialComponentSource = null,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .trial_component_arn = "TrialComponentArn",
        .trial_component_name = "TrialComponentName",
        .trial_component_source = "TrialComponentSource",
    };
};
