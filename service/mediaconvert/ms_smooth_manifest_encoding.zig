const std = @import("std");

/// Use Manifest encoding to specify the encoding format for the server and
/// client manifest. Valid options are utf8 and utf16.
pub const MsSmoothManifestEncoding = enum {
    utf8,
    utf16,

    pub const json_field_names = .{
        .utf8 = "UTF8",
        .utf16 = "UTF16",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .utf8 => "UTF8",
            .utf16 => "UTF16",
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
