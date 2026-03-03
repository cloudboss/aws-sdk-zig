const std = @import("std");

pub const EncodingName = enum {
    jxsv,
    raw,
    smpte_291,
    pcm,

    pub const json_field_names = .{
        .jxsv = "jxsv",
        .raw = "raw",
        .smpte_291 = "smpte291",
        .pcm = "pcm",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .jxsv => "jxsv",
            .raw => "raw",
            .smpte_291 => "smpte291",
            .pcm => "pcm",
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
