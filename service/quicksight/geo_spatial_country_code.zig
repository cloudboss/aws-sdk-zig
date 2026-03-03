const std = @import("std");

pub const GeoSpatialCountryCode = enum {
    us,

    pub const json_field_names = .{
        .us = "US",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .us => "US",
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
