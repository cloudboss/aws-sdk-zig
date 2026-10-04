const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateAliasInput = struct {
    /// Identifies the alias that is changing its KMS key. This value must begin
    /// with
    /// `alias/` followed by the alias name, such as `alias/ExampleAlias`. You
    /// cannot use `UpdateAlias` to change the alias name.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    alias_name: []const u8,

    /// Identifies the [customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-mgn-key) to associate
    /// with the alias. You don't have permission to associate an alias with an
    /// [Amazon Web Services managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-key).
    ///
    /// The KMS key must be in the same Amazon Web Services account and Region as
    /// the alias. Also, the new
    /// target KMS key must be the same type as the current target KMS key (both
    /// symmetric or both
    /// asymmetric or both HMAC) and they must have the same key usage.
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
    ///
    /// To verify that the alias is mapped to the correct KMS key, use ListAliases.
    target_key_id: []const u8,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .target_key_id = "TargetKeyId",
    };
};

pub const UpdateAliasOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAliasInput, options: CallOptions) !UpdateAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAliasInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.UpdateAlias");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAliasOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
