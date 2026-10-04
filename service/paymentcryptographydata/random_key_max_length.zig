const std = @import("std");

pub const RandomKeyMaxLength = enum {
    bytes_8,
    bytes_16,
    bytes_24,

    pub const json_field_names = .{
        .bytes_8 = "BYTES_8",
        .bytes_16 = "BYTES_16",
        .bytes_24 = "BYTES_24",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bytes_8 => "BYTES_8",
            .bytes_16 => "BYTES_16",
            .bytes_24 => "BYTES_24",
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
