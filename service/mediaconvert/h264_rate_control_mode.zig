const std = @import("std");

/// Use this setting to specify whether this output has a variable bitrate
/// (VBR), constant bitrate (CBR) or quality-defined variable bitrate (QVBR).
pub const H264RateControlMode = enum {
    vbr,
    cbr,
    qvbr,

    pub const json_field_names = .{
        .vbr = "VBR",
        .cbr = "CBR",
        .qvbr = "QVBR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vbr => "VBR",
            .cbr => "CBR",
            .qvbr => "QVBR",
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
