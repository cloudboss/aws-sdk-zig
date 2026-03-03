const std = @import("std");

pub const PinBlockFormatForPinData = enum {
    iso_format_0,
    iso_format_1,
    iso_format_3,
    iso_format_4,

    pub const json_field_names = .{
        .iso_format_0 = "ISO_FORMAT_0",
        .iso_format_1 = "ISO_FORMAT_1",
        .iso_format_3 = "ISO_FORMAT_3",
        .iso_format_4 = "ISO_FORMAT_4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iso_format_0 => "ISO_FORMAT_0",
            .iso_format_1 => "ISO_FORMAT_1",
            .iso_format_3 => "ISO_FORMAT_3",
            .iso_format_4 => "ISO_FORMAT_4",
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
