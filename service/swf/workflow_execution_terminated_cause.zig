const std = @import("std");

pub const WorkflowExecutionTerminatedCause = enum {
    child_policy_applied,
    event_limit_exceeded,
    operator_initiated,

    pub const json_field_names = .{
        .child_policy_applied = "CHILD_POLICY_APPLIED",
        .event_limit_exceeded = "EVENT_LIMIT_EXCEEDED",
        .operator_initiated = "OPERATOR_INITIATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .child_policy_applied => "CHILD_POLICY_APPLIED",
            .event_limit_exceeded => "EVENT_LIMIT_EXCEEDED",
            .operator_initiated => "OPERATOR_INITIATED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
