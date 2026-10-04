const std = @import("std");

/// Specify the AAC rate control mode. For a constant bitrate: Choose CBR. Your
/// AAC output bitrate will be equal to the value that you choose for Bitrate.
/// For a variable bitrate: Choose VBR. Your AAC output bitrate will vary
/// according to your audio content and the value that you choose for Bitrate
/// quality.
pub const AacRateControlMode = enum {
    cbr,
    vbr,

    pub const json_field_names = .{
        .cbr = "CBR",
        .vbr = "VBR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cbr => "CBR",
            .vbr => "VBR",
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
