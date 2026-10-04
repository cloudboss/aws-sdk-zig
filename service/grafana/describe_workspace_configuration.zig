const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeWorkspaceConfigurationInput = struct {
    /// The ID of the workspace to get configuration information for.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .workspace_id = "workspaceId",
    };
};

pub const DescribeWorkspaceConfigurationOutput = struct {
    /// The configuration string for the workspace that you requested. For more
    /// information about the format and configuration options available, see
    /// [Working in your Grafana
    /// workspace](https://docs.aws.amazon.com/grafana/latest/userguide/AMG-configure-workspace.html).
    configuration: []const u8,

    /// The supported Grafana version for the workspace.
    grafana_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .grafana_version = "grafanaVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWorkspaceConfigurationInput, options: CallOptions) !DescribeWorkspaceConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "grafana", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWorkspaceConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("grafana", "grafana", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/configuration");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWorkspaceConfigurationOutput {
    var result: DescribeWorkspaceConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeWorkspaceConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
