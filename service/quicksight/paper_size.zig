const std = @import("std");

pub const PaperSize = enum {
    us_letter,
    us_legal,
    us_tabloid_ledger,
    a0,
    a1,
    a2,
    a3,
    a4,
    a5,
    jis_b4,
    jis_b5,

    pub const json_field_names = .{
        .us_letter = "US_LETTER",
        .us_legal = "US_LEGAL",
        .us_tabloid_ledger = "US_TABLOID_LEDGER",
        .a0 = "A0",
        .a1 = "A1",
        .a2 = "A2",
        .a3 = "A3",
        .a4 = "A4",
        .a5 = "A5",
        .jis_b4 = "JIS_B4",
        .jis_b5 = "JIS_B5",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .us_letter => "US_LETTER",
            .us_legal => "US_LEGAL",
            .us_tabloid_ledger => "US_TABLOID_LEDGER",
            .a0 => "A0",
            .a1 => "A1",
            .a2 => "A2",
            .a3 => "A3",
            .a4 => "A4",
            .a5 => "A5",
            .jis_b4 => "JIS_B4",
            .jis_b5 => "JIS_B5",
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
