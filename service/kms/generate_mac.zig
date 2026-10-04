const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MacAlgorithmSpec = @import("mac_algorithm_spec.zig").MacAlgorithmSpec;

pub const GenerateMacInput = struct {
    /// Checks if your request will succeed. `DryRun` is an optional parameter.
    ///
    /// To learn more about how to use this parameter, see [Testing your
    /// permissions](https://docs.aws.amazon.com/kms/latest/developerguide/testing-permissions.html) in the *Key Management Service Developer Guide*.
    dry_run: ?bool = null,

    /// A list of grant tokens.
    ///
    /// Use a grant token when your permission to call this operation comes from a
    /// new grant that has not yet achieved *eventual consistency*. For more
    /// information, see [Grant
    /// token](https://docs.aws.amazon.com/kms/latest/developerguide/grants.html#grant_token) and [Using a grant token](https://docs.aws.amazon.com/kms/latest/developerguide/using-grant-token.html) in the
    /// *Key Management Service Developer Guide*.
    grant_tokens: ?[]const []const u8 = null,

    /// The HMAC KMS key to use in the operation. The MAC algorithm computes the
    /// HMAC for the
    /// message and the key as described in [RFC
    /// 2104](https://datatracker.ietf.org/doc/html/rfc2104).
    ///
    /// To identify an HMAC KMS key, use the DescribeKey operation and see the
    /// `KeySpec` field in the response.
    key_id: []const u8,

    /// The MAC algorithm used in the operation.
    ///
    /// The algorithm must be compatible with the HMAC KMS key that you specify. To
    /// find the MAC
    /// algorithms that your HMAC KMS key supports, use the DescribeKey operation
    /// and see the `MacAlgorithms` field in the `DescribeKey` response.
    mac_algorithm: MacAlgorithmSpec,

    /// The message to be hashed. Specify a message of up to 4,096 bytes.
    ///
    /// `GenerateMac` and VerifyMac do not provide special handling
    /// for message digests. If you generate an HMAC for a hash digest of a message,
    /// you must verify
    /// the HMAC of the same hash digest.
    message: []const u8,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .grant_tokens = "GrantTokens",
        .key_id = "KeyId",
        .mac_algorithm = "MacAlgorithm",
        .message = "Message",
    };
};

pub const GenerateMacOutput = struct {
    /// The HMAC KMS key used in the operation.
    key_id: ?[]const u8 = null,

    /// The hash-based message authentication code (HMAC) that was generated for the
    /// specified
    /// message, HMAC KMS key, and MAC algorithm.
    ///
    /// This is the standard, raw HMAC defined in [RFC
    /// 2104](https://datatracker.ietf.org/doc/html/rfc2104).
    mac: ?[]const u8 = null,

    /// The MAC algorithm that was used to generate the HMAC.
    mac_algorithm: ?MacAlgorithmSpec = null,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .mac = "Mac",
        .mac_algorithm = "MacAlgorithm",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateMacInput, options: CallOptions) !GenerateMacOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateMacInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.GenerateMac");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateMacOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GenerateMacOutput, body, allocator);
}
