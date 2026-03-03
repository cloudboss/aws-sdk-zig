const AccountTargeting = @import("account_targeting.zig").AccountTargeting;
const EmptyTargetResolutionMode = @import("empty_target_resolution_mode.zig").EmptyTargetResolutionMode;

/// Describes the experiment options for an experiment template.
pub const ExperimentTemplateExperimentOptions = struct {
    /// The account targeting setting for an experiment template.
    account_targeting: ?AccountTargeting = null,

    /// The empty target resolution mode for an experiment template.
    empty_target_resolution_mode: ?EmptyTargetResolutionMode = null,

    pub const json_field_names = .{
        .account_targeting = "accountTargeting",
        .empty_target_resolution_mode = "emptyTargetResolutionMode",
    };
};
