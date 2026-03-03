const std = @import("std");

/// Local TimeZone Detection method.
pub const LocalTimeZoneDetectionType = enum {
    zip_code,
    area_code,

    pub const json_field_names = .{
        .zip_code = "ZIP_CODE",
        .area_code = "AREA_CODE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .zip_code => "ZIP_CODE",
            .area_code => "AREA_CODE",
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
