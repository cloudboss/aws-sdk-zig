const ResolveTo = @import("resolve_to.zig").ResolveTo;
const TargetResource = @import("target_resource.zig").TargetResource;

/// Contains the summary of the actions, including information about where the
/// action resolves
/// to.
pub const ActionSummary = struct {
    /// The ID of the action definition.
    action_definition_id: ?[]const u8 = null,

    /// The ID of the action.
    action_id: ?[]const u8 = null,

    /// The detailed resource this action resolves to.
    resolve_to: ?ResolveTo = null,

    /// The resource the action will be taken on.
    target_resource: ?TargetResource = null,

    pub const json_field_names = .{
        .action_definition_id = "actionDefinitionId",
        .action_id = "actionId",
        .resolve_to = "resolveTo",
        .target_resource = "targetResource",
    };
};
