const std = @import("std");

pub const StartTimerFailedCause = enum {
    timer_id_already_in_use,
    open_timers_limit_exceeded,
    timer_creation_rate_exceeded,
    operation_not_permitted,

    pub const json_field_names = .{
        .timer_id_already_in_use = "TIMER_ID_ALREADY_IN_USE",
        .open_timers_limit_exceeded = "OPEN_TIMERS_LIMIT_EXCEEDED",
        .timer_creation_rate_exceeded = "TIMER_CREATION_RATE_EXCEEDED",
        .operation_not_permitted = "OPERATION_NOT_PERMITTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .timer_id_already_in_use => "TIMER_ID_ALREADY_IN_USE",
            .open_timers_limit_exceeded => "OPEN_TIMERS_LIMIT_EXCEEDED",
            .timer_creation_rate_exceeded => "TIMER_CREATION_RATE_EXCEEDED",
            .operation_not_permitted => "OPERATION_NOT_PERMITTED",
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
