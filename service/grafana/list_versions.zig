const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListVersionsInput = struct {
    /// The maximum number of results to include in the response.
    max_results: ?i32 = null,

    /// The token to use when requesting the next set of results. You receive this
    /// token from a previous `ListVersions` operation.
    next_token: ?[]const u8 = null,

    /// The ID of the workspace to list the available upgrade versions. If not
    /// included, lists all versions of Grafana that are supported for
    /// `CreateWorkspace`.
    workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .workspace_id = "workspaceId",
    };
};

pub const ListVersionsOutput = struct {
    /// The Grafana versions available to create. If a workspace ID is included in
    /// the request, the Grafana versions to which this workspace can be upgraded.
    grafana_versions: ?[]const []const u8 = null,

    /// The token to use in a subsequent `ListVersions` operation to return the next
    /// set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .grafana_versions = "grafanaVersions",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListVersionsInput, options: CallOptions) !ListVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("grafana", "grafana", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/versions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.workspace_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "workspace-id=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListVersionsOutput {
    var result: ListVersionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListVersionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
