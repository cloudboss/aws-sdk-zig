const std = @import("std");

pub const AttachmentContentTransferEncoding = enum {
    base64,
    quoted_printable,
    seven_bit,

    pub const json_field_names = .{
        .base64 = "BASE64",
        .quoted_printable = "QUOTED_PRINTABLE",
        .seven_bit = "SEVEN_BIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .base64 => "BASE64",
            .quoted_printable => "QUOTED_PRINTABLE",
            .seven_bit => "SEVEN_BIT",
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
