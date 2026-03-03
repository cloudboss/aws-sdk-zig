const std = @import("std");

pub const SpeedUnit = enum {
    kilometers_per_hour,
    miles_per_hour,

    pub const json_field_names = .{
        .kilometers_per_hour = "KilometersPerHour",
        .miles_per_hour = "MilesPerHour",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .kilometers_per_hour => "KilometersPerHour",
            .miles_per_hour => "MilesPerHour",
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
