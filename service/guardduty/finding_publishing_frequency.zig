const std = @import("std");

pub const FindingPublishingFrequency = enum {
    fifteen_minutes,
    one_hour,
    six_hours,

    pub const json_field_names = .{
        .fifteen_minutes = "FIFTEEN_MINUTES",
        .one_hour = "ONE_HOUR",
        .six_hours = "SIX_HOURS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fifteen_minutes => "FIFTEEN_MINUTES",
            .one_hour => "ONE_HOUR",
            .six_hours => "SIX_HOURS",
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
