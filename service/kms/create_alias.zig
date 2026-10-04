const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateAliasInput = struct {
    /// Specifies the alias name. This value must begin with `alias/` followed by a
    /// name, such as `alias/ExampleAlias`.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    ///
    /// The `AliasName` value must be string of 1-256 characters. It can contain
    /// only
    /// alphanumeric characters, forward slashes (/), underscores (_), and dashes
    /// (-). The alias name
    /// cannot begin with `alias/aws/`. The `alias/aws/` prefix is reserved for
    /// [Amazon Web Services managed
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-key).
    alias_name: []const u8,

    /// Associates the alias with the specified [customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-mgn-key). The KMS key
    /// must be in the same Amazon Web Services Region.
    ///
    /// A valid key ID is required. If you supply a null or empty string value, this
    /// operation
    /// returns an error.
    ///
    /// For help finding the key ID and ARN, see [Find the key ID and key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/find-cmk-id-arn.html) in
    /// the *
    /// Key Management Service Developer Guide*
    /// .
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
    target_key_id: []const u8,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .target_key_id = "TargetKeyId",
    };
};

pub const CreateAliasOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAliasInput, options: CallOptions) !CreateAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAliasInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.CreateAlias");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAliasOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
