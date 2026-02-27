const AccountTargeting = @import("account_targeting.zig").AccountTargeting;
const ActionsMode = @import("actions_mode.zig").ActionsMode;
const EmptyTargetResolutionMode = @import("empty_target_resolution_mode.zig").EmptyTargetResolutionMode;

/// Describes the options for an experiment.
pub const ExperimentOptions = struct {
    /// The account targeting setting for an experiment.
    account_targeting: ?AccountTargeting,

    /// The actions mode of the experiment that is set from the StartExperiment API
    /// command.
    actions_mode: ?ActionsMode,

    /// The empty target resolution mode for an experiment.
    empty_target_resolution_mode: ?EmptyTargetResolutionMode,

    pub const json_field_names = .{
        .account_targeting = "accountTargeting",
        .actions_mode = "actionsMode",
        .empty_target_resolution_mode = "emptyTargetResolutionMode",
    };
};
