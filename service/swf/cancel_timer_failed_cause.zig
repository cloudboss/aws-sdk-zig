const std = @import("std");

pub const CancelTimerFailedCause = enum {
    timer_id_unknown,
    operation_not_permitted,

    pub const json_field_names = .{
        .timer_id_unknown = "TIMER_ID_UNKNOWN",
        .operation_not_permitted = "OPERATION_NOT_PERMITTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .timer_id_unknown => "TIMER_ID_UNKNOWN",
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
