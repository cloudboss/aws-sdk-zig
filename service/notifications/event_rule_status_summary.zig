const EventRuleStatus = @import("event_rule_status.zig").EventRuleStatus;

/// Provides additional information about the current `EventRule` status.
pub const EventRuleStatusSummary = struct {
    /// A human-readable reason for `EventRuleStatus`.
    reason: []const u8,

    /// The status of the `EventRule`.
    ///
    /// * Values:
    ///
    /// * `ACTIVE`
    ///
    /// * The `EventRule` can process events.
    ///
    /// * `INACTIVE`
    ///
    /// * The `EventRule` may be unable to process events.
    ///
    /// * `CREATING`
    ///
    /// * The `EventRule` is being created.
    ///
    /// Only `GET` and `LIST` calls can be run.
    ///
    /// * `UPDATING`
    ///
    /// * The `EventRule` is being updated.
    ///
    /// Only `GET` and `LIST` calls can be run.
    ///
    /// * `DELETING`
    ///
    /// * The `EventRule` is being deleted.
    ///
    /// Only `GET` and `LIST` calls can be run.
    status: EventRuleStatus,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
