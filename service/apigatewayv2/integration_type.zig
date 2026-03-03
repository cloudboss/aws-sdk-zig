const std = @import("std");

/// Represents an API method integration type.
pub const IntegrationType = enum {
    aws,
    http,
    mock,
    http_proxy,
    aws_proxy,

    pub const json_field_names = .{
        .aws = "AWS",
        .http = "HTTP",
        .mock = "MOCK",
        .http_proxy = "HTTP_PROXY",
        .aws_proxy = "AWS_PROXY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws => "AWS",
            .http => "HTTP",
            .mock => "MOCK",
            .http_proxy => "HTTP_PROXY",
            .aws_proxy => "AWS_PROXY",
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
