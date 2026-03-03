const std = @import("std");

/// Required when you set Dolby Vision Profile to Profile 8.1. When you set
/// Content mapping to None, content mapping is not applied to the
/// HDR10-compatible signal. Depending on the source peak nit level, clipping
/// might occur on HDR devices without Dolby Vision. When you set Content
/// mapping to HDR10 1000, the transcoder creates a 1,000 nits peak
/// HDR10-compatible signal by applying static content mapping to the source.
/// This mode is speed-optimized for PQ10 sources with metadata that is created
/// from analysis. For graded Dolby Vision content, be aware that creative
/// intent might not be guaranteed with extreme 1,000 nits trims.
pub const DolbyVisionMapping = enum {
    hdr10_nomap,
    hdr10_1000,

    pub const json_field_names = .{
        .hdr10_nomap = "HDR10_NOMAP",
        .hdr10_1000 = "HDR10_1000",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hdr10_nomap => "HDR10_NOMAP",
            .hdr10_1000 => "HDR10_1000",
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
