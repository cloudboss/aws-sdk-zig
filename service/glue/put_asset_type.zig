const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetTypeFormReference = @import("asset_type_form_reference.zig").AssetTypeFormReference;

pub const PutAssetTypeInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The forms that make up the asset type, keyed by form name. Each entry
    /// references the form type that defines the form's schema.
    forms: []const aws.map.MapEntry(AssetTypeFormReference),

    /// The name of the asset type.
    name: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .forms = "Forms",
        .name = "Name",
    };
};

pub const PutAssetTypeOutput = struct {
    /// The forms that make up the asset type, keyed by form name.
    forms: ?[]const aws.map.MapEntry(AssetTypeFormReference) = null,

    /// The identifier of the asset type.
    id: ?[]const u8 = null,

    /// The name of the asset type.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .forms = "Forms",
        .id = "Id",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAssetTypeInput, options: CallOptions) !PutAssetTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAssetTypeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.PutAssetType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAssetTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutAssetTypeOutput, body, allocator);
}
