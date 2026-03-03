const std = @import("std");

pub const WeekDay = enum {
    sunday,
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,

    pub const json_field_names = .{
        .sunday = "sunday",
        .monday = "monday",
        .tuesday = "tuesday",
        .wednesday = "wednesday",
        .thursday = "thursday",
        .friday = "friday",
        .saturday = "saturday",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sunday => "sunday",
            .monday => "monday",
            .tuesday => "tuesday",
            .wednesday => "wednesday",
            .thursday => "thursday",
            .friday => "friday",
            .saturday => "saturday",
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
