const std = @import("std");

pub const LogAnomalyType = enum {
    keyword,
    keyword_token,
    format,
    http_code,
    block_format,
    numerical_point,
    numerical_nan,
    new_field_name,

    pub const json_field_names = .{
        .keyword = "KEYWORD",
        .keyword_token = "KEYWORD_TOKEN",
        .format = "FORMAT",
        .http_code = "HTTP_CODE",
        .block_format = "BLOCK_FORMAT",
        .numerical_point = "NUMERICAL_POINT",
        .numerical_nan = "NUMERICAL_NAN",
        .new_field_name = "NEW_FIELD_NAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .keyword => "KEYWORD",
            .keyword_token => "KEYWORD_TOKEN",
            .format => "FORMAT",
            .http_code => "HTTP_CODE",
            .block_format => "BLOCK_FORMAT",
            .numerical_point => "NUMERICAL_POINT",
            .numerical_nan => "NUMERICAL_NAN",
            .new_field_name => "NEW_FIELD_NAME",
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
