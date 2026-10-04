const std = @import("std");

pub const ScheduledQueryRunStatus = enum {
    auto_trigger_success,
    auto_trigger_failure,
    manual_trigger_success,
    manual_trigger_failure,

    pub const json_field_names = .{
        .auto_trigger_success = "AUTO_TRIGGER_SUCCESS",
        .auto_trigger_failure = "AUTO_TRIGGER_FAILURE",
        .manual_trigger_success = "MANUAL_TRIGGER_SUCCESS",
        .manual_trigger_failure = "MANUAL_TRIGGER_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto_trigger_success => "AUTO_TRIGGER_SUCCESS",
            .auto_trigger_failure => "AUTO_TRIGGER_FAILURE",
            .manual_trigger_success => "MANUAL_TRIGGER_SUCCESS",
            .manual_trigger_failure => "MANUAL_TRIGGER_FAILURE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
