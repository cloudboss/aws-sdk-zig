const PossibleRemediationAction = @import("possible_remediation_action.zig").PossibleRemediationAction;

/// A list of possible remediation action lists. Each individual possible
/// remediation action is a list of individual remediation actions.
pub const PossibleRemediationActions = struct {
    /// Information about the actions.
    actions: ?[]const PossibleRemediationAction = null,

    /// A description of the possible remediation actions list.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .description = "Description",
    };
};
