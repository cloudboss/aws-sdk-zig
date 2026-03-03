const std = @import("std");

/// When set to XDCAM, writes MPEG2 video streams into the QuickTime file using
/// XDCAM fourcc codes. This increases compatibility with Apple editors and
/// players, but may decrease compatibility with other players. Only applicable
/// when the video codec is MPEG2.
pub const MovMpeg2FourCCControl = enum {
    xdcam,
    mpeg,

    pub const json_field_names = .{
        .xdcam = "XDCAM",
        .mpeg = "MPEG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .xdcam => "XDCAM",
            .mpeg => "MPEG",
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
