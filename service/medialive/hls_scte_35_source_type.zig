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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
