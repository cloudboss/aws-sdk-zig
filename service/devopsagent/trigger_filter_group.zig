const TriggerEvent = @import("trigger_event.zig").TriggerEvent;
const PatternFilter = @import("pattern_filter.zig").PatternFilter;

/// A group of trigger conditions. The group matches when ALL present conditions
/// pass. A group cannot be empty: at least one condition must be present.
pub const TriggerFilterGroup = struct {
    /// Passes when the webhook event is one of the listed events.
    events: ?[]const TriggerEvent = null,

    /// Passes when the change request target branch matches. Applicable to
    /// RELEASE_READINESS_REVIEW only.
    target_branches: ?PatternFilter = null,

    pub const json_field_names = .{
        .events = "events",
        .target_branches = "targetBranches",
    };
};
