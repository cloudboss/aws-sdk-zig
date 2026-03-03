const std = @import("std");

/// Generate a variant manifest that lists only the I-frames for this rendition.
/// You might use this manifest as part of a workflow that creates preview
/// functions for your video. MediaConvert adds both the I-frame only variant
/// manifest and the regular variant manifest to the multivariant manifest. To
/// have MediaConvert write a variant manifest that references I-frames from
/// your output content using EXT-X-BYTERANGE tags: Choose Include. To have
/// MediaConvert output I-frames as single frame TS files and a corresponding
/// variant manifest that references them: Choose Include as TS. When you don't
/// need the I-frame only variant manifest: Keep the default value, Exclude.
pub const HlsIFrameOnlyManifest = enum {
    include,
    include_as_ts,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .include_as_ts = "INCLUDE_AS_TS",
        .exclude = "EXCLUDE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .include => "INCLUDE",
            .include_as_ts => "INCLUDE_AS_TS",
            .exclude => "EXCLUDE",
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
