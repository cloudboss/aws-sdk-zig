const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionType = @import("encryption_type.zig").EncryptionType;

pub const StopStreamEncryptionInput = struct {
    /// The encryption type. The only valid value is `KMS`.
    encryption_type: EncryptionType,

    /// The GUID for the customer-managed Amazon Web Services KMS key to use for
    /// encryption.
    /// This value can be a globally unique identifier, a fully specified Amazon
    /// Resource Name
    /// (ARN) to either an alias or a key, or an alias name prefixed by "alias/".You
    /// can also
    /// use a master key owned by Kinesis Data Streams by specifying the alias
    /// `aws/kinesis`.
    ///
    /// * Key ARN example:
    /// `arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012`
    ///
    /// * Alias ARN example:
    /// `arn:aws:kms:us-east-1:123456789012:alias/MyAliasName`
    ///
    /// * Globally unique key ID example:
    /// `12345678-1234-1234-1234-123456789012`
    ///
    /// * Alias name example: `alias/MyAliasName`
    ///
    /// * Master key owned by Kinesis Data Streams:
    /// `alias/aws/kinesis`
    key_id: []const u8,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// The name of the stream on which to stop encrypting records.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_type = "EncryptionType",
        .key_id = "KeyId",
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
        .stream_name = "StreamName",
    };
};

pub const StopStreamEncryptionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopStreamEncryptionInput, options: CallOptions) !StopStreamEncryptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopStreamEncryptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesis", "Kinesis", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.StopStreamEncryption");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopStreamEncryptionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
