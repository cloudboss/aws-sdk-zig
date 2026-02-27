const HookTargetAction = @import("hook_target_action.zig").HookTargetAction;
const HookTargetType = @import("hook_target_type.zig").HookTargetType;

/// The `HookTarget` data type.
pub const HookTarget = struct {
    /// The action that invoked the Hook.
    action: HookTargetAction,

    /// The unique identifier of the Hook invocation target.
    target_id: []const u8,

    /// The target type.
    target_type: HookTargetType,

    /// The target name, for example, `AWS::S3::Bucket`.
    target_type_name: []const u8,
};
