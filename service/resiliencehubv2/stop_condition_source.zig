const std = @import("std");

/// The source of a test stop condition, matching AWS Fault Injection Service
/// (AWS FIS) stop condition sources.
pub const StopConditionSource = enum {
    aws_cloudwatch_alarm,
    none,

    pub const json_field_names = .{
        .aws_cloudwatch_alarm = "aws:cloudwatch:alarm",
        .none = "none",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_cloudwatch_alarm => "aws:cloudwatch:alarm",
            .none => "none",
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
