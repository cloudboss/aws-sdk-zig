const std = @import("std");

pub const TargetType = enum {
    open_api_schema,
    smithy_model,
    mcp_server,
    lambda,
    api_gateway,
    connector,
    agentcore_runtime,
    passthrough,
    provider,
    http_connector,

    pub const json_field_names = .{
        .open_api_schema = "OPEN_API_SCHEMA",
        .smithy_model = "SMITHY_MODEL",
        .mcp_server = "MCP_SERVER",
        .lambda = "LAMBDA",
        .api_gateway = "API_GATEWAY",
        .connector = "CONNECTOR",
        .agentcore_runtime = "AGENTCORE_RUNTIME",
        .passthrough = "PASSTHROUGH",
        .provider = "PROVIDER",
        .http_connector = "HTTP_CONNECTOR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open_api_schema => "OPEN_API_SCHEMA",
            .smithy_model => "SMITHY_MODEL",
            .mcp_server => "MCP_SERVER",
            .lambda => "LAMBDA",
            .api_gateway => "API_GATEWAY",
            .connector => "CONNECTOR",
            .agentcore_runtime => "AGENTCORE_RUNTIME",
            .passthrough => "PASSTHROUGH",
            .provider => "PROVIDER",
            .http_connector => "HTTP_CONNECTOR",
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
