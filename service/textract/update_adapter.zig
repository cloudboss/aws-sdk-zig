const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoUpdate = @import("auto_update.zig").AutoUpdate;
const FeatureType = @import("feature_type.zig").FeatureType;

pub const UpdateAdapterInput = struct {
    /// A string containing a unique ID for the adapter that will be updated.
    adapter_id: []const u8,

    /// The new name to be applied to the adapter.
    adapter_name: ?[]const u8 = null,

    /// The new auto-update status to be applied to the adapter.
    auto_update: ?AutoUpdate = null,

    /// The new description to be applied to the adapter.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .adapter_name = "AdapterName",
        .auto_update = "AutoUpdate",
        .description = "Description",
    };
};

pub const UpdateAdapterOutput = struct {
    /// A string containing a unique ID for the adapter that has been updated.
    adapter_id: ?[]const u8 = null,

    /// A string containing the name of the adapter that has been updated.
    adapter_name: ?[]const u8 = null,

    /// The auto-update status of the adapter that has been updated.
    auto_update: ?AutoUpdate = null,

    /// An object specifying the creation time of the the adapter that has been
    /// updated.
    creation_time: ?i64 = null,

    /// A string containing the description of the adapter that has been updated.
    description: ?[]const u8 = null,

    /// List of the targeted feature types for the updated adapter.
    feature_types: ?[]const FeatureType = null,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .adapter_name = "AdapterName",
        .auto_update = "AutoUpdate",
        .creation_time = "CreationTime",
        .description = "Description",
        .feature_types = "FeatureTypes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAdapterInput, options: CallOptions) !UpdateAdapterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAdapterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Textract.UpdateAdapter");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAdapterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateAdapterOutput, body, allocator);
}
