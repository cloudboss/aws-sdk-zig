const std = @import("std");

pub const FormatToHeaderKey = enum {
    chr,
    start,
    end,
    ref,
    alt,
    pos,

    pub const json_field_names = .{
        .chr = "CHR",
        .start = "START",
        .end = "END",
        .ref = "REF",
        .alt = "ALT",
        .pos = "POS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .chr => "CHR",
            .start => "START",
            .end => "END",
            .ref => "REF",
            .alt => "ALT",
            .pos => "POS",
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
