const std = @import("std");

/// When set to CBR, inserts null packets into transport stream to fill
/// specified bitrate. When set to VBR, the bitrate setting acts as the maximum
/// bitrate, but the output will not be padded up to that bitrate.
pub const M2tsRateMode = enum {
    vbr,
    cbr,

    pub const json_field_names = .{
        .vbr = "VBR",
        .cbr = "CBR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vbr => "VBR",
            .cbr => "CBR",
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
