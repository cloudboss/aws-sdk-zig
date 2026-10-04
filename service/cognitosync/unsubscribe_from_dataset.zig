const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UnsubscribeFromDatasetInput = struct {
    /// The name of the dataset from which to unsubcribe.
    dataset_name: []const u8,

    /// The unique ID generated for this device by Cognito.
    device_id: []const u8,

    /// Unique ID for this identity.
    identity_id: []const u8,

    /// A name-spaced GUID (for example,
    /// us-east-1:23EC4050-6AEA-7089-A2DD-08002EXAMPLE) created by
    /// Amazon Cognito. The ID of the pool to which this identity belongs.
    identity_pool_id: []const u8,

    pub const json_field_names = .{
        .dataset_name = "DatasetName",
        .device_id = "DeviceId",
        .identity_id = "IdentityId",
        .identity_pool_id = "IdentityPoolId",
    };
};

pub const UnsubscribeFromDatasetOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UnsubscribeFromDatasetInput, options: CallOptions) !UnsubscribeFromDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-sync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UnsubscribeFromDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-sync", "Cognito Sync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/identitypools/");
    try path_buf.appendSlice(allocator, input.identity_pool_id);
    try path_buf.appendSlice(allocator, "/identities/");
    try path_buf.appendSlice(allocator, input.identity_id);
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.dataset_name);
    try path_buf.appendSlice(allocator, "/subscriptions/");
    try path_buf.appendSlice(allocator, input.device_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UnsubscribeFromDatasetOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UnsubscribeFromDatasetOutput = .{};

    return result;
}
