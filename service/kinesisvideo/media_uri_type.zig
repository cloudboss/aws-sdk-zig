const std = @import("std");

pub const MediaUriType = enum {
    rtsp_uri,
    file_uri,

    pub const json_field_names = .{
        .rtsp_uri = "RTSP_URI",
        .file_uri = "FILE_URI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rtsp_uri => "RTSP_URI",
            .file_uri => "FILE_URI",
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
