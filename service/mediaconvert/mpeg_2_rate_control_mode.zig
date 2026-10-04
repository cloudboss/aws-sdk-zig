const std = @import("std");

/// Use Rate control mode to specify whether the bitrate is variable (vbr) or
/// constant (cbr).
pub const Mpeg2RateControlMode = enum {
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
