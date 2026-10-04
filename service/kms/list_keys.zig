const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeyListEntry = @import("key_list_entry.zig").KeyListEntry;

pub const ListKeysInput = struct {
    /// Use this parameter to specify the maximum number of items to return. When
    /// this
    /// value is present, KMS does not return more than the specified number of
    /// items, but it might
    /// return fewer.
    ///
    /// This value is optional. If you include a value, it must be between
    /// 1 and 1000, inclusive. If you do not include a value, it defaults to 100.
    limit: ?i32 = null,

    /// Use this parameter in a subsequent request after you receive a response with
    /// truncated results. Set it to the value of `NextMarker` from the truncated
    /// response
    /// you just received.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .marker = "Marker",
    };
};

pub const ListKeysOutput = struct {
    /// A list of KMS keys.
    keys: ?[]const KeyListEntry = null,

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
        .keys = "Keys",
        .next_marker = "NextMarker",
        .truncated = "Truncated",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListKeysInput, options: CallOptions) !ListKeysOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListKeysInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.ListKeys");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListKeysOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListKeysOutput, body, allocator);
}
