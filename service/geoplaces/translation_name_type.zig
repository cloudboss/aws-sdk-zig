const std = @import("std");

pub const TranslationNameType = enum {
    abbreviation,
    area_code,
    base_name,
    exonym,
    shortened,
    synonym,

    pub const json_field_names = .{
        .abbreviation = "Abbreviation",
        .area_code = "AreaCode",
        .base_name = "BaseName",
        .exonym = "Exonym",
        .shortened = "Shortened",
        .synonym = "Synonym",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .abbreviation => "Abbreviation",
            .area_code => "AreaCode",
            .base_name => "BaseName",
            .exonym => "Exonym",
            .shortened => "Shortened",
            .synonym => "Synonym",
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
