const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VirtualNodeSpec = @import("virtual_node_spec.zig").VirtualNodeSpec;
const VirtualNodeData = @import("virtual_node_data.zig").VirtualNodeData;

pub const UpdateVirtualNodeInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the
    /// request. Up to 36 letters, numbers, hyphens, and underscores are allowed.
    client_token: ?[]const u8 = null,

    /// The name of the service mesh that the virtual node resides in.
    mesh_name: []const u8,

    /// The Amazon Web Services IAM account ID of the service mesh owner. If the
    /// account ID is not your own, then it's
    /// the ID of the account that shared the mesh with your account. For more
    /// information about mesh sharing, see [Working with shared
    /// meshes](https://docs.aws.amazon.com/app-mesh/latest/userguide/sharing.html).
    mesh_owner: ?[]const u8 = null,

    /// The new virtual node specification to apply. This overwrites the existing
    /// data.
    spec: VirtualNodeSpec,

    /// The name of the virtual node to update.
    virtual_node_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .mesh_name = "meshName",
        .mesh_owner = "meshOwner",
        .spec = "spec",
        .virtual_node_name = "virtualNodeName",
    };
};

pub const UpdateVirtualNodeOutput = struct {
    /// A full description of the virtual node that was updated.
    virtual_node: ?VirtualNodeData = null,

    pub const json_field_names = .{
        .virtual_node = "virtualNode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateVirtualNodeInput, options: CallOptions) !UpdateVirtualNodeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateVirtualNodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appmesh", "App Mesh", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20190125/meshes/");
    try path_buf.appendSlice(allocator, input.mesh_name);
    try path_buf.appendSlice(allocator, "/virtualNodes/");
    try path_buf.appendSlice(allocator, input.virtual_node_name);
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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"spec\":");
    try aws.json.writeValue(@TypeOf(input.spec), input.spec, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateVirtualNodeOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateVirtualNodeOutput = .{};

    return result;
}
