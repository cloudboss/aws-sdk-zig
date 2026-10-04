const std = @import("std");

/// Specify the video sample composition time offset mode in the output fMP4
/// TRUN box. For wider player compatibility, set Video composition offsets to
/// Unsigned or leave blank. The earliest presentation time may be greater than
/// zero, and sample composition time offsets will increment using unsigned
/// integers. For strict fMP4 video and audio timing, set Video composition
/// offsets to Signed. The earliest presentation time will be equal to zero, and
/// sample composition time offsets will increment using signed integers.
pub const CmafVideoCompositionOffsets = enum {
    signed,
    unsigned,

    pub const json_field_names = .{
        .signed = "SIGNED",
        .unsigned = "UNSIGNED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .signed => "SIGNED",
            .unsigned => "UNSIGNED",
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
