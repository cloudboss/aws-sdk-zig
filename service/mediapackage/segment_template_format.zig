const std = @import("std");

pub const SegmentTemplateFormat = enum {
    number_with_timeline,
    time_with_timeline,
    number_with_duration,

    pub const json_field_names = .{
        .number_with_timeline = "NUMBER_WITH_TIMELINE",
        .time_with_timeline = "TIME_WITH_TIMELINE",
        .number_with_duration = "NUMBER_WITH_DURATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .number_with_timeline => "NUMBER_WITH_TIMELINE",
            .time_with_timeline => "TIME_WITH_TIMELINE",
            .number_with_duration => "NUMBER_WITH_DURATION",
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
