const std = @import("std");

pub const DocumentationPartType = enum {
    api,
    authorizer,
    model,
    resource,
    method,
    path_parameter,
    query_parameter,
    request_header,
    request_body,
    response,
    response_header,
    response_body,

    pub const json_field_names = .{
        .api = "API",
        .authorizer = "AUTHORIZER",
        .model = "MODEL",
        .resource = "RESOURCE",
        .method = "METHOD",
        .path_parameter = "PATH_PARAMETER",
        .query_parameter = "QUERY_PARAMETER",
        .request_header = "REQUEST_HEADER",
        .request_body = "REQUEST_BODY",
        .response = "RESPONSE",
        .response_header = "RESPONSE_HEADER",
        .response_body = "RESPONSE_BODY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .api => "API",
            .authorizer => "AUTHORIZER",
            .model => "MODEL",
            .resource => "RESOURCE",
            .method => "METHOD",
            .path_parameter => "PATH_PARAMETER",
            .query_parameter => "QUERY_PARAMETER",
            .request_header => "REQUEST_HEADER",
            .request_body => "REQUEST_BODY",
            .response => "RESPONSE",
            .response_header => "RESPONSE_HEADER",
            .response_body => "RESPONSE_BODY",
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
