const std = @import("std");

/// Hls Webdav Http Transfer Mode
pub const HlsWebdavHttpTransferMode = enum {
    chunked,
    non_chunked,

    pub const json_field_names = .{
        .chunked = "CHUNKED",
        .non_chunked = "NON_CHUNKED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .chunked => "CHUNKED",
            .non_chunked => "NON_CHUNKED",
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
