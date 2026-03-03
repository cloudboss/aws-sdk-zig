const ChangeSetHookResourceTargetDetails = @import("change_set_hook_resource_target_details.zig").ChangeSetHookResourceTargetDetails;
const HookTargetType = @import("hook_target_type.zig").HookTargetType;

/// Specifies target details for an activated Hook.
pub const ChangeSetHookTargetDetails = struct {
    /// Required if `TargetType` is `RESOURCE`.
    resource_target_details: ?ChangeSetHookResourceTargetDetails = null,

    /// The Hook target type.
    target_type: ?HookTargetType = null,
};
