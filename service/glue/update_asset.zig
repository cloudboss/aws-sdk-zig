const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateAssetInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The new description of the asset.
    description: ?[]const u8 = null,

    /// The unique identifier of the asset to update.
    identifier: []const u8,

    /// The new name of the asset.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .identifier = "Identifier",
        .name = "Name",
    };
};

pub const UpdateAssetOutput = struct {
    /// The description of the asset.
    description: ?[]const u8 = null,

    /// The unique identifier of the asset.
    id: []const u8,

    /// The name of the asset.
    name: ?[]const u8 = null,

    /// The timestamp at which the asset was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssetInput, options: CallOptions) !UpdateAssetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.UpdateAsset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateAssetOutput, body, allocator);
}
