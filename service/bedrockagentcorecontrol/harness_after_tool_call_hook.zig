const HarnessHookTarget = @import("harness_hook_target.zig").HarnessHookTarget;

/// The configuration for a hook that runs after a tool call completes.
pub const HarnessAfterToolCallHook = struct {
    /// The name of the hook.
    name: []const u8,

    /// The target that receives the hook event.
    target: HarnessHookTarget,

    pub const json_field_names = .{
        .name = "name",
        .target = "target",
    };
};
