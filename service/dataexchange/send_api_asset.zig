const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SendApiAssetInput = struct {
    /// Asset ID value for the API request.
    asset_id: []const u8,

    /// The request body.
    body: ?[]const u8 = null,

    /// Data set ID value for the API request.
    data_set_id: []const u8,

    /// HTTP method value for the API request. Alternatively, you can use the
    /// appropriate verb in your request.
    method: ?[]const u8 = null,

    /// URI path value for the API request. Alternatively, you can set the URI path
    /// directly by invoking /v1/{pathValue}.
    path: ?[]const u8 = null,

    /// Attach query string parameters to the end of the URI (for example,
    /// /v1/examplePath?exampleParam=exampleValue).
    query_string_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Any header value prefixed with x-amzn-dataexchange-header- will have that
    /// stripped before sending the Asset API request. Use this when you want to
    /// override a header that AWS Data Exchange uses. Alternatively, you can use
    /// the header without a prefix to the HTTP request.
    request_headers: ?[]const aws.map.StringMapEntry = null,

    /// Revision ID value for the API request.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .body = "Body",
        .data_set_id = "DataSetId",
        .method = "Method",
        .path = "Path",
        .query_string_parameters = "QueryStringParameters",
        .request_headers = "RequestHeaders",
        .revision_id = "RevisionId",
    };
};

pub const SendApiAssetOutput = struct {
    /// The response body from the underlying API tracked by the API asset.
    body: ?[]const u8 = null,

    /// The response headers from the underlying API tracked by the API asset.
    response_headers: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .body = "Body",
        .response_headers = "ResponseHeaders",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendApiAssetInput, options: CallOptions) !SendApiAssetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendApiAssetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataexchange", "DataExchange", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1";

    const body = input.body orelse "";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amzn-dataexchange-asset-id", input.asset_id);
    try request.headers.put(allocator, "x-amzn-dataexchange-data-set-id", input.data_set_id);
    if (input.method) |v| {
        try request.headers.put(allocator, "x-amzn-dataexchange-http-method", v);
    }
    if (input.path) |v| {
        try request.headers.put(allocator, "x-amzn-dataexchange-path", v);
    }
    try request.headers.put(allocator, "x-amzn-dataexchange-revision-id", input.revision_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendApiAssetOutput {
    var result: SendApiAssetOutput = .{};
    if (body.len > 0) {
        result.body = try allocator.dupe(u8, body);
    }
    _ = status;
    _ = headers;

    return result;
}
