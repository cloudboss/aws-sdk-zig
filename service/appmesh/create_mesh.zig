const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MeshSpec = @import("mesh_spec.zig").MeshSpec;
const TagRef = @import("tag_ref.zig").TagRef;
const MeshData = @import("mesh_data.zig").MeshData;

pub const CreateMeshInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the
    /// request. Up to 36 letters, numbers, hyphens, and underscores are allowed.
    client_token: ?[]const u8 = null,

    /// The name to use for the service mesh.
    mesh_name: []const u8,

    /// The service mesh specification to apply.
    spec: ?MeshSpec = null,

    /// Optional metadata that you can apply to the service mesh to assist with
    /// categorization
    /// and organization. Each tag consists of a key and an optional value, both of
    /// which you
    /// define. Tag keys can have a maximum character length of 128 characters, and
    /// tag values can have
    /// a maximum length of 256 characters.
    tags: ?[]const TagRef = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .mesh_name = "meshName",
        .spec = "spec",
        .tags = "tags",
    };
};

pub const CreateMeshOutput = struct {
    /// The full description of your service mesh following the create call.
    mesh: ?MeshData = null,

    pub const json_field_names = .{
        .mesh = "mesh",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMeshInput, options: CallOptions) !CreateMeshOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMeshInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appmesh", "App Mesh", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20190125/meshes";

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
    try body_buf.appendSlice(allocator, "\"meshName\":");
    try aws.json.writeValue(@TypeOf(input.mesh_name), input.mesh_name, allocator, &body_buf);
    has_prev = true;
    if (input.spec) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"spec\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMeshOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CreateMeshOutput = .{};

    return result;
}
