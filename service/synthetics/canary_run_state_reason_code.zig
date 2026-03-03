const std = @import("std");

pub const CanaryRunStateReasonCode = enum {
    canary_failure,
    execution_failure,

    pub const json_field_names = .{
        .canary_failure = "CANARY_FAILURE",
        .execution_failure = "EXECUTION_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .canary_failure => "CANARY_FAILURE",
            .execution_failure => "EXECUTION_FAILURE",
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
