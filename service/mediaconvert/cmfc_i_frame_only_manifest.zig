const std = @import("std");

/// Choose Include to have MediaConvert generate an HLS child manifest that
/// lists only the I-frames for this rendition, in addition to your regular
/// manifest for this rendition. You might use this manifest as part of a
/// workflow that creates preview functions for your video. MediaConvert adds
/// both the I-frame only child manifest and the regular child manifest to the
/// parent manifest. When you don't need the I-frame only child manifest, keep
/// the default value Exclude.
pub const CmfcIFrameOnlyManifest = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .include => "INCLUDE",
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
