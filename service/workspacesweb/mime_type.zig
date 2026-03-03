const std = @import("std");

pub const MimeType = enum {
    png,
    jpeg,
    ico,

    pub const json_field_names = .{
        .png = "image/png",
        .jpeg = "image/jpeg",
        .ico = "image/x-icon",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .png => "image/png",
            .jpeg => "image/jpeg",
            .ico => "image/x-icon",
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
