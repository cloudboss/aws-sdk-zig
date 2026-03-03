const std = @import("std");

/// To place the MOOV atom at the beginning of your output, which is useful for
/// progressive downloading: Leave blank or choose Progressive download. To
/// place the MOOV at the end of your output: Choose Normal.
pub const Mp4MoovPlacement = enum {
    progressive_download,
    normal,

    pub const json_field_names = .{
        .progressive_download = "PROGRESSIVE_DOWNLOAD",
        .normal = "NORMAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .progressive_download => "PROGRESSIVE_DOWNLOAD",
            .normal => "NORMAL",
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
