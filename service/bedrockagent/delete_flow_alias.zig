const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteFlowAliasInput = struct {
    /// The unique identifier of the alias to be deleted.
    alias_identifier: []const u8,

    /// The unique identifier of the flow that the alias belongs to.
    flow_identifier: []const u8,

    pub const json_field_names = .{
        .alias_identifier = "aliasIdentifier",
        .flow_identifier = "flowIdentifier",
    };
};

pub const DeleteFlowAliasOutput = struct {
    /// The unique identifier of the flow that the alias belongs to.
    flow_id: []const u8,

    /// The unique identifier of the flow.
    id: []const u8,

    pub const json_field_names = .{
        .flow_id = "flowId",
        .id = "id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFlowAliasInput, options: CallOptions) !DeleteFlowAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFlowAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/aliases/");
    try path_buf.appendSlice(allocator, input.alias_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFlowAliasOutput {
    const result: DeleteFlowAliasOutput = try aws.json.parseJsonObject(
        DeleteFlowAliasOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
