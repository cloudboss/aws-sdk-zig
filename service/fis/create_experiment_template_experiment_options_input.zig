const AccountTargeting = @import("account_targeting.zig").AccountTargeting;
const EmptyTargetResolutionMode = @import("empty_target_resolution_mode.zig").EmptyTargetResolutionMode;

/// Specifies experiment options for an experiment template.
pub const CreateExperimentTemplateExperimentOptionsInput = struct {
    /// Specifies the account targeting setting for experiment options.
    account_targeting: ?AccountTargeting,

    /// Specifies the empty target resolution mode for experiment options.
    empty_target_resolution_mode: ?EmptyTargetResolutionMode,

    pub const json_field_names = .{
        .account_targeting = "accountTargeting",
        .empty_target_resolution_mode = "emptyTargetResolutionMode",
    };
};
