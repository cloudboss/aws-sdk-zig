const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteDataLakeNamespaceInput = struct {
    /// The AWS Supply Chain instance identifier.
    instance_id: []const u8,

    /// The name of the namespace. Noted you cannot delete pre-defined namespace
    /// like **asc**, **default** which are only deleted through instance deletion.
    name: []const u8,

    pub const json_field_names = .{
        .instance_id = "instanceId",
        .name = "name",
    };
};

pub const DeleteDataLakeNamespaceOutput = struct {
    /// The AWS Supply Chain instance identifier.
    instance_id: []const u8,

    /// The name of deleted namespace.
    name: []const u8,

    pub const json_field_names = .{
        .instance_id = "instanceId",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDataLakeNamespaceInput, options: CallOptions) !DeleteDataLakeNamespaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "scn", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDataLakeNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scn", "SupplyChain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/datalake/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/namespaces/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDataLakeNamespaceOutput {
    var result: DeleteDataLakeNamespaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteDataLakeNamespaceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
