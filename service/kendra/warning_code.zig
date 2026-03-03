const std = @import("std");

pub const WarningCode = enum {
    query_language_invalid_syntax,

    pub const json_field_names = .{
        .query_language_invalid_syntax = "QUERY_LANGUAGE_INVALID_SYNTAX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .query_language_invalid_syntax => "QUERY_LANGUAGE_INVALID_SYNTAX",
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
