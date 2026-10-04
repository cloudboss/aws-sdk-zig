const std = @import("std");

pub const StopAction = enum {
    start_evaluation,
    skip_evaluation,

    pub const json_field_names = .{
        .start_evaluation = "START_EVALUATION",
        .skip_evaluation = "SKIP_EVALUATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_evaluation => "START_EVALUATION",
            .skip_evaluation => "SKIP_EVALUATION",
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
