const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomKeyStoresListEntry = @import("custom_key_stores_list_entry.zig").CustomKeyStoresListEntry;

pub const DescribeCustomKeyStoresInput = struct {
    /// Gets only information about the specified custom key store. Enter the key
    /// store ID.
    ///
    /// By default, this operation gets information about all custom key stores in
    /// the account and
    /// Region. To limit the output to a particular custom key store, provide either
    /// the
    /// `CustomKeyStoreId` or `CustomKeyStoreName` parameter, but not
    /// both.
    custom_key_store_id: ?[]const u8 = null,

    /// Gets only information about the specified custom key store. Enter the
    /// friendly name of the
    /// custom key store.
    ///
    /// By default, this operation gets information about all custom key stores in
    /// the account and
    /// Region. To limit the output to a particular custom key store, provide either
    /// the
    /// `CustomKeyStoreId` or `CustomKeyStoreName` parameter, but not
    /// both.
    custom_key_store_name: ?[]const u8 = null,

    /// Use this parameter to specify the maximum number of items to return. When
    /// this
    /// value is present, KMS does not return more than the specified number of
    /// items, but it might
    /// return fewer.
    limit: ?i32 = null,

    /// Use this parameter in a subsequent request after you receive a response with
    /// truncated results. Set it to the value of `NextMarker` from the truncated
    /// response
    /// you just received.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_key_store_id = "CustomKeyStoreId",
        .custom_key_store_name = "CustomKeyStoreName",
        .limit = "Limit",
        .marker = "Marker",
    };
};

pub const DescribeCustomKeyStoresOutput = struct {
    /// Contains metadata about each custom key store.
    custom_key_stores: ?[]const CustomKeyStoresListEntry = null,

    /// When `Truncated` is true, this element is present and contains the
    /// value to use for the `Marker` parameter in a subsequent request.
    next_marker: ?[]const u8 = null,

    /// A flag that indicates whether there are more items in the list. When this
    /// value is true, the list in this response is truncated. To get more items,
    /// pass the value of
    /// the `NextMarker` element in this response to the `Marker` parameter in a
    /// subsequent request.
    truncated: ?bool = null,

    pub const json_field_names = .{
        .custom_key_stores = "CustomKeyStores",
        .next_marker = "NextMarker",
        .truncated = "Truncated",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCustomKeyStoresInput, options: CallOptions) !DescribeCustomKeyStoresOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCustomKeyStoresInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kms", "KMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.DescribeCustomKeyStores");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCustomKeyStoresOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCustomKeyStoresOutput, body, allocator);
}
