const std = @import("std");

pub const FieldToProtectType = enum {
    single_header,
    single_cookie,
    single_query_argument,
    query_string,
    body,

    pub const json_field_names = .{
        .single_header = "SINGLE_HEADER",
        .single_cookie = "SINGLE_COOKIE",
        .single_query_argument = "SINGLE_QUERY_ARGUMENT",
        .query_string = "QUERY_STRING",
        .body = "BODY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_header => "SINGLE_HEADER",
            .single_cookie => "SINGLE_COOKIE",
            .single_query_argument => "SINGLE_QUERY_ARGUMENT",
            .query_string => "QUERY_STRING",
            .body => "BODY",
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
