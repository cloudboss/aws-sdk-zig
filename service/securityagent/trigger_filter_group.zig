const TriggerEvent = @import("trigger_event.zig").TriggerEvent;
const TriggerFilter = @import("trigger_filter.zig").TriggerFilter;

/// A set of conditions that start an automatic code review when they all pass.
/// A filter group must include `events`, `filters`, or both.
pub const TriggerFilterGroup = struct {
    /// Passes when the pull request event is one of the listed events. If you omit
    /// this, the group matches `PULL_REQUEST_READY_FOR_REVIEW` and
    /// `PULL_REQUEST_DRAFT` events only.
    events: ?[]const TriggerEvent = null,

    /// Passes when every filter passes. If you omit this, the group matches its
    /// events on any target branch and with any labels.
    filters: ?[]const TriggerFilter = null,

    pub const json_field_names = .{
        .events = "events",
        .filters = "filters",
    };
};
