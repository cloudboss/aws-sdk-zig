const std = @import("std");

/// Ignore this setting unless you have SCTE-35 markers in your input video
/// file. Choose Passthrough if you want SCTE-35 markers that appear in your
/// input to also appear in this output. Choose None if you don't want those
/// SCTE-35 markers in this output. When your input is an HLS manifest, choose
/// Manifest cues to pass through CUE markers in your HLS manifest as segment
/// boundaries and SCTE-35 markers in this output at each EXT-X-CUE-OUT splice
/// point in the input manifest.
pub const MpdScte35Source = enum {
    passthrough,
    none,
    manifest_cues,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .none = "NONE",
        .manifest_cues = "MANIFEST_CUES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passthrough => "PASSTHROUGH",
            .none => "NONE",
            .manifest_cues => "MANIFEST_CUES",
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
