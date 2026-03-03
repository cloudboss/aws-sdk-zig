const aws = @import("aws");

/// Specifies an action for an experiment template.
///
/// For more information, see
/// [Actions](https://docs.aws.amazon.com/fis/latest/userguide/actions.html)
/// in the *Fault Injection Service User Guide*.
pub const CreateExperimentTemplateActionInput = struct {
    /// The ID of the action. The format of the action ID is:
    /// aws:*service-name*:*action-type*.
    action_id: []const u8,

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
