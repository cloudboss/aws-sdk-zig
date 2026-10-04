const std = @import("std");

pub const PreParseTextTransformationType = enum {
    none,
    url_decode,
    url_decode_uni,
    combine_duplicate_query_args_by_comma,
    replace_semicolons_with_ampersands,

    pub const json_field_names = .{
        .none = "NONE",
        .url_decode = "URL_DECODE",
        .url_decode_uni = "URL_DECODE_UNI",
        .combine_duplicate_query_args_by_comma = "COMBINE_DUPLICATE_QUERY_ARGS_BY_COMMA",
        .replace_semicolons_with_ampersands = "REPLACE_SEMICOLONS_WITH_AMPERSANDS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .url_decode => "URL_DECODE",
            .url_decode_uni => "URL_DECODE_UNI",
            .combine_duplicate_query_args_by_comma => "COMBINE_DUPLICATE_QUERY_ARGS_BY_COMMA",
            .replace_semicolons_with_ampersands => "REPLACE_SEMICOLONS_WITH_AMPERSANDS",
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
