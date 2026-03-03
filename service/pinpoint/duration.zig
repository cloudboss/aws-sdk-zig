const std = @import("std");

pub const Duration = enum {
    hr_24,
    day_7,
    day_14,
    day_30,

    pub const json_field_names = .{
        .hr_24 = "HR_24",
        .day_7 = "DAY_7",
        .day_14 = "DAY_14",
        .day_30 = "DAY_30",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hr_24 => "HR_24",
            .day_7 => "DAY_7",
            .day_14 => "DAY_14",
            .day_30 => "DAY_30",
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
