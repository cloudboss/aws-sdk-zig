const HarnessHookDecision = @import("harness_hook_decision.zig").HarnessHookDecision;
const HarnessHookEventType = @import("harness_hook_event_type.zig").HarnessHookEventType;

/// A lifecycle hook event emitted in the invocation stream for visibility into
/// hook decisions.
pub const HarnessHookEvent = struct {
    /// The decision applied to the hook event. This field is present only for
    /// blocking Lambda targets.
    decision: ?HarnessHookDecision = null,

    /// The unique identifier for this hook event.
    hook_event_id: []const u8,

    /// The name of the hook that ran.
    name: []const u8,

    /// The optional reason for the applied decision.
    reason: ?[]const u8 = null,

    /// The type of lifecycle hook event.
    @"type": HarnessHookEventType,

    pub const json_field_names = .{
        .decision = "decision",
        .hook_event_id = "hookEventId",
        .name = "name",
        .reason = "reason",
        .@"type" = "type",
    };
};
