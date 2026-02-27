const aws = @import("aws");

const ExperimentActionState = @import("experiment_action_state.zig").ExperimentActionState;

/// Describes the action for an experiment.
pub const ExperimentAction = struct {
    /// The ID of the action.
    action_id: ?[]const u8,

    /// The description for the action.
    description: ?[]const u8,

    /// The time that the action ended.
    end_time: ?i64,

    /// The parameters for the action.
    parameters: ?[]const aws.map.StringMapEntry,

    /// The name of the action that must be completed before this action starts.
    start_after: ?[]const []const u8,

    /// The time that the action started.
    start_time: ?i64,

    /// The state of the action.
    state: ?ExperimentActionState,

    /// The targets for the action.
    targets: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .action_id = "actionId",
        .description = "description",
        .end_time = "endTime",
        .parameters = "parameters",
        .start_after = "startAfter",
        .start_time = "startTime",
        .state = "state",
        .targets = "targets",
    };
};
