const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoUpdate = @import("auto_update.zig").AutoUpdate;
const FeatureType = @import("feature_type.zig").FeatureType;

pub const GetAdapterInput = struct {
    /// A string containing a unique ID for the adapter.
    adapter_id: []const u8,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
    };
};

pub const GetAdapterOutput = struct {
    /// A string identifying the adapter that information has been retrieved for.
    adapter_id: ?[]const u8 = null,

    /// The name of the requested adapter.
    adapter_name: ?[]const u8 = null,

    /// Binary value indicating if the adapter is being automatically updated or
    /// not.
    auto_update: ?AutoUpdate = null,

    /// The date and time the requested adapter was created at.
    creation_time: ?i64 = null,

    /// The description for the requested adapter.
    description: ?[]const u8 = null,

    /// List of the targeted feature types for the requested adapter.
    feature_types: ?[]const FeatureType = null,

    /// A set of tags (key-value pairs) associated with the adapter that has been
    /// retrieved.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .adapter_name = "AdapterName",
        .auto_update = "AutoUpdate",
        .creation_time = "CreationTime",
        .description = "Description",
        .feature_types = "FeatureTypes",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAdapterInput, options: CallOptions) !GetAdapterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAdapterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Textract.GetAdapter");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAdapterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAdapterOutput, body, allocator);
}
