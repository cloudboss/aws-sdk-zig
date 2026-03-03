const std = @import("std");

pub const EvaluatorLevel = enum {
    tool_call,
    trace,
    session,

    pub const json_field_names = .{
        .tool_call = "TOOL_CALL",
        .trace = "TRACE",
        .session = "SESSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tool_call => "TOOL_CALL",
            .trace => "TRACE",
            .session => "SESSION",
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
