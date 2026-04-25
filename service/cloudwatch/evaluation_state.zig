const std = @import("std");

pub const EvaluationState = enum {
    partial_data,
    evaluation_failure,
    evaluation_error,

    pub const json_field_names = .{
        .partial_data = "PARTIAL_DATA",
        .evaluation_failure = "EVALUATION_FAILURE",
        .evaluation_error = "EVALUATION_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .partial_data => "PARTIAL_DATA",
            .evaluation_failure => "EVALUATION_FAILURE",
            .evaluation_error => "EVALUATION_ERROR",
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
