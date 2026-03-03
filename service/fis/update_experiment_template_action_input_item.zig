const aws = @import("aws");

/// Specifies an action for an experiment template.
pub const UpdateExperimentTemplateActionInputItem = struct {
    /// The ID of the action.
    action_id: ?[]const u8 = null,

    /// A description for the action.
    description: ?[]const u8 = null,

    /// The parameters for the action, if applicable.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The name of the action that must be completed before the current action
    /// starts. Omit this parameter to run the action at the start of the
    /// experiment.
    start_after: ?[]const []const u8 = null,

    /// The targets for the action.
    targets: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .action_id = "actionId",
        .description = "description",
        .parameters = "parameters",
        .start_after = "startAfter",
        .targets = "targets",
    };
};
