const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RotateKeyOnDemandInput = struct {
    /// Identifies a symmetric encryption KMS key. You cannot perform on-demand
    /// rotation of [asymmetric KMS
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html), [HMAC KMS
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/hmac.html),
    /// multi-Region KMS keys with [imported key
    /// material](https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html), or KMS keys in a
    /// [custom key
    /// store](https://docs.aws.amazon.com/kms/latest/developerguide/key-store-overview.html). To perform on-demand rotation of a set of related [multi-Region
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html#multi-region-rotate), invoke the on-demand rotation on the primary key.
    ///
    /// Specify the key ID or key ARN of the KMS key.
    ///
    /// For example:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Key ARN:
    ///   `arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// To get the key ID and key ARN for a KMS key, use ListKeys or DescribeKey.
    key_id: []const u8,

    pub const json_field_names = .{
        .key_id = "KeyId",
    };
};

pub const RotateKeyOnDemandOutput = struct {
    /// Identifies the symmetric encryption KMS key that you initiated on-demand
    /// rotation
    /// on.
    key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .key_id = "KeyId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RotateKeyOnDemandInput, options: CallOptions) !RotateKeyOnDemandOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RotateKeyOnDemandInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.RotateKeyOnDemand");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RotateKeyOnDemandOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RotateKeyOnDemandOutput, body, allocator);
}
