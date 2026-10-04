const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteFlowVersionInput = struct {
    /// The unique identifier of the flow whose version that you want to delete
    flow_identifier: []const u8,

    /// The version of the flow that you want to delete.
    flow_version: []const u8,

    /// By default, this value is `false` and deletion is stopped if the resource is
    /// in use. If you set it to `true`, the resource will be deleted even if the
    /// resource is in use.
    skip_resource_in_use_check: ?bool = null,

    pub const json_field_names = .{
        .flow_identifier = "flowIdentifier",
        .flow_version = "flowVersion",
        .skip_resource_in_use_check = "skipResourceInUseCheck",
    };
};

pub const DeleteFlowVersionOutput = struct {
    /// The unique identifier of the flow.
    id: []const u8,

    /// The version of the flow being deleted.
    version: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFlowVersionInput, options: CallOptions) !DeleteFlowVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFlowVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.flow_version);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.skip_resource_in_use_check) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "skipResourceInUseCheck=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFlowVersionOutput {
    const result: DeleteFlowVersionOutput = try aws.json.parseJsonObject(
        DeleteFlowVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
