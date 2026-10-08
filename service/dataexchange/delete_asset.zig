const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteAssetInput = struct {
    /// The unique identifier for an asset.
    asset_id: []const u8,

    /// The unique identifier for a data set.
    data_set_id: []const u8,

    /// The unique identifier for a revision.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .data_set_id = "DataSetId",
        .revision_id = "RevisionId",
    };
};

pub const DeleteAssetOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAssetInput, options: CallOptions) !DeleteAssetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dataexchange", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAssetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataexchange", "DataExchange", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/data-sets/");
    try path_buf.appendSlice(allocator, input.data_set_id);
    try path_buf.appendSlice(allocator, "/revisions/");
    try path_buf.appendSlice(allocator, input.revision_id);
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.asset_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAssetOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteAssetOutput = .{};

    return result;
}
