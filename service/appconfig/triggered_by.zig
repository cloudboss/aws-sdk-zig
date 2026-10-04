const std = @import("std");

pub const TriggeredBy = enum {
    user,
    appconfig,
    cloudwatch_alarm,
    internal_error,

    pub const json_field_names = .{
        .user = "USER",
        .appconfig = "APPCONFIG",
        .cloudwatch_alarm = "CLOUDWATCH_ALARM",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user => "USER",
            .appconfig => "APPCONFIG",
            .cloudwatch_alarm => "CLOUDWATCH_ALARM",
            .internal_error => "INTERNAL_ERROR",
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
