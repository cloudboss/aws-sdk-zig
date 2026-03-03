const std = @import("std");

/// Hls Scte35 Source Type
pub const HlsScte35SourceType = enum {
    manifest,
    segments,

    pub const json_field_names = .{
        .manifest = "MANIFEST",
        .segments = "SEGMENTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .manifest => "MANIFEST",
            .segments => "SEGMENTS",
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
