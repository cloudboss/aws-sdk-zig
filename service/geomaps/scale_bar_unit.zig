const std = @import("std");

pub const ScaleBarUnit = enum {
    kilometers,
    kilometers_miles,
    miles,
    miles_kilometers,

    pub const json_field_names = .{
        .kilometers = "Kilometers",
        .kilometers_miles = "KilometersMiles",
        .miles = "Miles",
        .miles_kilometers = "MilesKilometers",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .kilometers => "Kilometers",
            .kilometers_miles => "KilometersMiles",
            .miles => "Miles",
            .miles_kilometers => "MilesKilometers",
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
