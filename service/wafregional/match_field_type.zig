const std = @import("std");

pub const MatchFieldType = enum {
    uri,
    query_string,
    header,
    method,
    body,
    single_query_arg,
    all_query_args,

    pub const json_field_names = .{
        .uri = "URI",
        .query_string = "QUERY_STRING",
        .header = "HEADER",
        .method = "METHOD",
        .body = "BODY",
        .single_query_arg = "SINGLE_QUERY_ARG",
        .all_query_args = "ALL_QUERY_ARGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .uri => "URI",
            .query_string => "QUERY_STRING",
            .header => "HEADER",
            .method => "METHOD",
            .body => "BODY",
            .single_query_arg => "SINGLE_QUERY_ARG",
            .all_query_args => "ALL_QUERY_ARGS",
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
