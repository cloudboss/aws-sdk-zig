const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetFormEntry = @import("asset_form_entry.zig").AssetFormEntry;

pub const PutAssetInput = struct {
    /// The identifier of the asset type for the asset.
    asset_type_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The description of the asset.
    description: ?[]const u8 = null,

    /// The forms to set on the asset, keyed by form name. Each entry specifies the
    /// form type and its JSON content.
    forms: []const aws.map.MapEntry(AssetFormEntry),

    /// The unique identifier of the asset. If an asset with this identifier already
    /// exists, it is updated.
    identifier: []const u8,

    /// The name of the asset.
    name: []const u8,

    pub const json_field_names = .{
        .asset_type_id = "AssetTypeId",
        .client_token = "ClientToken",
        .description = "Description",
        .forms = "Forms",
        .identifier = "Identifier",
        .name = "Name",
    };
};

pub const PutAssetOutput = struct {
    /// The timestamp at which the asset was created.
    created_at: ?i64 = null,

    /// The description of the asset.
    description: ?[]const u8 = null,

    /// The forms attached to the asset, keyed by form name.
    forms: ?[]const aws.map.MapEntry(AssetFormEntry) = null,

    /// The unique identifier of the asset.
    id: []const u8,

    /// The name of the asset.
    name: []const u8,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .forms = "Forms",
        .id = "Id",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAssetInput, options: CallOptions) !PutAssetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAssetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.PutAsset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAssetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PutAssetOutput, body, allocator);
}
