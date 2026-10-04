const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoUpdate = @import("auto_update.zig").AutoUpdate;
const FeatureType = @import("feature_type.zig").FeatureType;

pub const CreateAdapterInput = struct {
    /// The name to be assigned to the adapter being created.
    adapter_name: []const u8,

    /// Controls whether or not the adapter should automatically update.
    auto_update: ?AutoUpdate = null,

    /// Idempotent token is used to recognize the request. If the same token is used
    /// with multiple
    /// CreateAdapter requests, the same session is returned.
    /// This token is employed to avoid unintentionally creating the same session
    /// multiple times.
    client_request_token: ?[]const u8 = null,

    /// The description to be assigned to the adapter being created.
    description: ?[]const u8 = null,

    /// The type of feature that the adapter is being trained on. Currrenly,
    /// supported feature
    /// types are: `QUERIES`
    feature_types: []const FeatureType,

    /// A list of tags to be added to the adapter.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .adapter_name = "AdapterName",
        .auto_update = "AutoUpdate",
        .client_request_token = "ClientRequestToken",
        .description = "Description",
        .feature_types = "FeatureTypes",
        .tags = "Tags",
    };
};

pub const CreateAdapterOutput = struct {
    /// A string containing the unique ID for the adapter that has been created.
    adapter_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAdapterInput, options: CallOptions) !CreateAdapterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "textract", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAdapterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("textract", "Textract", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Textract.CreateAdapter");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAdapterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAdapterOutput, body, allocator);
}
