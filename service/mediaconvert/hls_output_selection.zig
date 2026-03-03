const std = @import("std");

/// Indicates whether the .m3u8 manifest file should be generated for this HLS
/// output group.
pub const HlsOutputSelection = enum {
    manifests_and_segments,
    segments_only,

    pub const json_field_names = .{
        .manifests_and_segments = "MANIFESTS_AND_SEGMENTS",
        .segments_only = "SEGMENTS_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .manifests_and_segments => "MANIFESTS_AND_SEGMENTS",
            .segments_only => "SEGMENTS_ONLY",
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
