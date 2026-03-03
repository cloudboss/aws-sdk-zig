const std = @import("std");

pub const ElasticsearchIndexRotationPeriod = enum {
    no_rotation,
    one_hour,
    one_day,
    one_week,
    one_month,

    pub const json_field_names = .{
        .no_rotation = "NoRotation",
        .one_hour = "OneHour",
        .one_day = "OneDay",
        .one_week = "OneWeek",
        .one_month = "OneMonth",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_rotation => "NoRotation",
            .one_hour => "OneHour",
            .one_day => "OneDay",
            .one_week => "OneWeek",
            .one_month => "OneMonth",
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
