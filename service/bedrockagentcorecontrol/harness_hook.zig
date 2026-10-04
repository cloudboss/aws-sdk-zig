const HarnessAfterInvocationHook = @import("harness_after_invocation_hook.zig").HarnessAfterInvocationHook;
const HarnessAfterToolCallHook = @import("harness_after_tool_call_hook.zig").HarnessAfterToolCallHook;
const HarnessBeforeInvocationHook = @import("harness_before_invocation_hook.zig").HarnessBeforeInvocationHook;
const HarnessBeforeToolCallHook = @import("harness_before_tool_call_hook.zig").HarnessBeforeToolCallHook;

/// A lifecycle hook configuration. Specify one hook type.
pub const HarnessHook = union(enum) {
    /// A hook that runs after an invocation completes.
    after_invocation: ?HarnessAfterInvocationHook,
    /// A hook that runs after a tool call completes.
    after_tool_call: ?HarnessAfterToolCallHook,
    /// A hook that runs before an invocation begins.
    before_invocation: ?HarnessBeforeInvocationHook,
    /// A hook that runs before the agent calls a tool.
    before_tool_call: ?HarnessBeforeToolCallHook,

    pub const json_field_names = .{
        .after_invocation = "afterInvocation",
        .after_tool_call = "afterToolCall",
        .before_invocation = "beforeInvocation",
        .before_tool_call = "beforeToolCall",
    };
};
