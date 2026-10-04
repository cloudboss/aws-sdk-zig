const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeyLastUsageData = @import("key_last_usage_data.zig").KeyLastUsageData;

pub const GetKeyLastUsageInput = struct {
    /// Identifies the KMS key to get usage information for. To specify a KMS key,
    /// use its key ID
    /// or key ARN. Alias names are not supported.
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

pub const GetKeyLastUsageOutput = struct {
    /// The date and time when the KMS key was created.
    key_creation_date: ?i64 = null,

    /// The globally unique identifier for the KMS key.
    key_id: ?[]const u8 = null,

    /// Contains usage information about the last time the KMS key was used for a
    /// successful cryptographic
    /// operation. If the key has not been used since tracking began, this response
    /// element is
    /// empty.
    key_last_usage: ?KeyLastUsageData = null,

    /// The date from which KMS began recording cryptographic activity for this key,
    /// or the date
    /// the KMS key was created, whichever is later.
    tracking_start_date: ?i64 = null,

    pub const json_field_names = .{
        .key_creation_date = "KeyCreationDate",
        .key_id = "KeyId",
        .key_last_usage = "KeyLastUsage",
        .tracking_start_date = "TrackingStartDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetKeyLastUsageInput, options: CallOptions) !GetKeyLastUsageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetKeyLastUsageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.GetKeyLastUsage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetKeyLastUsageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetKeyLastUsageOutput, body, allocator);
}
