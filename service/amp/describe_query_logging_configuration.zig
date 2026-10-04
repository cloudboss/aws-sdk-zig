const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryLoggingConfigurationMetadata = @import("query_logging_configuration_metadata.zig").QueryLoggingConfigurationMetadata;

pub const DescribeQueryLoggingConfigurationInput = struct {
    /// The ID of the workspace for which to retrieve the query logging
    /// configuration.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .workspace_id = "workspaceId",
    };
};

pub const DescribeQueryLoggingConfigurationOutput = struct {
    /// The detailed information about the query logging configuration for the
    /// specified workspace.
    query_logging_configuration: ?QueryLoggingConfigurationMetadata = null,

    pub const json_field_names = .{
        .query_logging_configuration = "queryLoggingConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeQueryLoggingConfigurationInput, options: CallOptions) !DescribeQueryLoggingConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aps", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeQueryLoggingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/logging/query");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeQueryLoggingConfigurationOutput {
    var result: DescribeQueryLoggingConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeQueryLoggingConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
