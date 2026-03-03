const std = @import("std");

/// M2ts Rate Mode
pub const M2tsRateMode = enum {
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
