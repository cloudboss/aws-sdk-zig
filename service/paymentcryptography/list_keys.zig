const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeyState = @import("key_state.zig").KeyState;
const KeySummary = @import("key_summary.zig").KeySummary;

pub const ListKeysInput = struct {
    /// The key state of the keys you want to list.
    key_state: ?KeyState = null,

    /// Use this parameter to specify the maximum number of items to return. When
    /// this value is present, Amazon Web Services Payment Cryptography does not
    /// return more than the specified number of items, but it might return fewer.
    ///
    /// This value is optional. If you include a value, it must be between 1 and
    /// 100, inclusive. If you do not include a value, it defaults to 50.
    max_results: ?i32 = null,

    /// Use this parameter in a subsequent request after you receive a response with
    /// truncated results. Set it to the value of `NextToken` from the truncated
    /// response you just received.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .key_state = "KeyState",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListKeysOutput = struct {
    /// The list of keys created within the caller's Amazon Web Services account and
    /// Amazon Web Services Region.
    keys: ?[]const KeySummary = null,

    /// The token for the next set of results, or an empty or null value if there
    /// are no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .keys = "Keys",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListKeysInput, options: CallOptions) !ListKeysOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "payment-cryptography", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("controlplane.payment-cryptography", "Payment Cryptography", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.ListKeys");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListKeysOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListKeysOutput, body, allocator);
}
