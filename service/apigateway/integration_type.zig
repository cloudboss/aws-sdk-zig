const std = @import("std");

/// The integration type. The valid value is `HTTP` for integrating an API
/// method with an HTTP backend; `AWS` with any Amazon Web Services service
/// endpoints; `MOCK` for testing without actually invoking the backend;
/// `HTTP_PROXY` for integrating with the HTTP proxy integration; `AWS_PROXY`
/// for integrating with the Lambda proxy integration.
pub const IntegrationType = enum {
    http,
    aws,
    mock,
    http_proxy,
    aws_proxy,

    pub const json_field_names = .{
        .http = "HTTP",
        .aws = "AWS",
        .mock = "MOCK",
        .http_proxy = "HTTP_PROXY",
        .aws_proxy = "AWS_PROXY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .http => "HTTP",
            .aws => "AWS",
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
