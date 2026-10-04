const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdatePrimaryRegionInput = struct {
    /// Identifies the current primary key. When the operation completes, this KMS
    /// key will be a
    /// replica key.
    ///
    /// Specify the key ID or key ARN of a multi-Region primary key.
    ///
    /// For example:
    ///
    /// * Key ID: `mrk-1234abcd12ab34cd56ef1234567890ab`
    ///
    /// * Key ARN:
    ///   `arn:aws:kms:us-east-2:111122223333:key/mrk-1234abcd12ab34cd56ef1234567890ab`
    ///
    /// To get the key ID and key ARN for a KMS key, use ListKeys or DescribeKey.
    key_id: []const u8,

    /// The Amazon Web Services Region of the new primary key. Enter the Region ID,
    /// such as
    /// `us-east-1` or `ap-southeast-2`. There must be an existing replica key
    /// in this Region.
    ///
    /// When the operation completes, the multi-Region key in this Region will be
    /// the primary
    /// key.
    primary_region: []const u8,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .primary_region = "PrimaryRegion",
    };
};

pub const UpdatePrimaryRegionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePrimaryRegionInput, options: CallOptions) !UpdatePrimaryRegionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePrimaryRegionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.UpdatePrimaryRegion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePrimaryRegionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
