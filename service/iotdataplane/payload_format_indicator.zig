const std = @import("std");

pub const PayloadFormatIndicator = enum {
    unspecified_bytes,
    utf8_data,

    pub const json_field_names = .{
        .unspecified_bytes = "UNSPECIFIED_BYTES",
        .utf8_data = "UTF8_DATA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unspecified_bytes => "UNSPECIFIED_BYTES",
            .utf8_data => "UTF8_DATA",
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
