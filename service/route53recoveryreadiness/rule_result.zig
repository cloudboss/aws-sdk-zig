const Message = @import("message.zig").Message;
const Readiness = @import("readiness.zig").Readiness;

/// The result of a successful Rule request, with status for an individual rule.
pub const RuleResult = struct {
    /// The time the resource was last checked for readiness, in ISO-8601 format,
    /// UTC.
    last_checked_timestamp: i64,

    /// Details about the resource's readiness.
    messages: []const Message,

    /// The readiness at rule level.
    readiness: Readiness,

    /// The identifier of the rule.
    rule_id: []const u8,

    pub const json_field_names = .{
        .last_checked_timestamp = "LastCheckedTimestamp",
        .messages = "Messages",
        .readiness = "Readiness",
        .rule_id = "RuleId",
    };
};
