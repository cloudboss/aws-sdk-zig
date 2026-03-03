const std = @import("std");

pub const GeoMatchLevel = enum {
    country,
    area_code,

    pub const json_field_names = .{
        .country = "Country",
        .area_code = "AreaCode",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .country => "Country",
            .area_code => "AreaCode",
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
