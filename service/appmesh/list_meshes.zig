const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MeshRef = @import("mesh_ref.zig").MeshRef;

pub const ListMeshesInput = struct {
    /// The maximum number of results returned by `ListMeshes` in paginated output.
    /// When you use this parameter, `ListMeshes` returns only `limit`
    /// results in a single page along with a `nextToken` response element. You can
    /// see
    /// the remaining results of the initial request by sending another `ListMeshes`
    /// request with the returned `nextToken` value. This value can be between
    /// 1 and 100. If you don't use this parameter,
    /// `ListMeshes` returns up to 100 results and a
    /// `nextToken` value if applicable.
    limit: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `ListMeshes` request where `limit` was used and the results
    /// exceeded the value of that parameter. Pagination continues from the end of
    /// the previous
    /// results that returned the `nextToken` value.
    ///
    /// This token should be treated as an opaque identifier that is used only to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "limit",
        .next_token = "nextToken",
    };
};

pub const ListMeshesOutput = struct {
    /// The list of existing service meshes.
    meshes: ?[]const MeshRef = null,

    /// The `nextToken` value to include in a future `ListMeshes` request.
    /// When the results of a `ListMeshes` request exceed `limit`, you can
    /// use this value to retrieve the next page of results. This value is `null`
    /// when
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .meshes = "meshes",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMeshesInput, options: CallOptions) !ListMeshesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMeshesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appmesh", "App Mesh", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20190125/meshes";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.limit) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "limit=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMeshesOutput {
    var result: ListMeshesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListMeshesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
