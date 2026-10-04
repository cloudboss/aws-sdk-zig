const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VirtualRouterData = @import("virtual_router_data.zig").VirtualRouterData;

pub const DeleteVirtualRouterInput = struct {
    /// The name of the service mesh to delete the virtual router in.
    mesh_name: []const u8,

    /// The Amazon Web Services IAM account ID of the service mesh owner. If the
    /// account ID is not your own, then it's
    /// the ID of the account that shared the mesh with your account. For more
    /// information about mesh sharing, see [Working with shared
    /// meshes](https://docs.aws.amazon.com/app-mesh/latest/userguide/sharing.html).
    mesh_owner: ?[]const u8 = null,

    /// The name of the virtual router to delete.
    virtual_router_name: []const u8,

    pub const json_field_names = .{
        .mesh_name = "meshName",
        .mesh_owner = "meshOwner",
        .virtual_router_name = "virtualRouterName",
    };
};

pub const DeleteVirtualRouterOutput = struct {
    /// The virtual router that was deleted.
    virtual_router: ?VirtualRouterData = null,

    pub const json_field_names = .{
        .virtual_router = "virtualRouter",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteVirtualRouterInput, options: CallOptions) !DeleteVirtualRouterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appmesh", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteVirtualRouterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appmesh", "App Mesh", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20190125/meshes/");
    try path_buf.appendSlice(allocator, input.mesh_name);
    try path_buf.appendSlice(allocator, "/virtualRouters/");
    try path_buf.appendSlice(allocator, input.virtual_router_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.mesh_owner) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "meshOwner=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteVirtualRouterOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteVirtualRouterOutput = .{};

    return result;
}
