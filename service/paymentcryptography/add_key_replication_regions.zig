const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Key = @import("key.zig").Key;

pub const AddKeyReplicationRegionsInput = struct {
    /// The key identifier (ARN or alias) of the key for which to add replication
    /// regions.
    ///
    /// This key must exist and be in a valid state for replication operations.
    key_identifier: []const u8,

    /// The list of Amazon Web Services Regions to add to the key's replication
    /// configuration.
    ///
    /// Each region must be a valid Amazon Web Services Region where Amazon Web
    /// Services Payment Cryptography is available. The key will be replicated to
    /// these regions, allowing cryptographic operations to be performed closer to
    /// your applications.
    replication_regions: []const []const u8,

    pub const json_field_names = .{
        .key_identifier = "KeyIdentifier",
        .replication_regions = "ReplicationRegions",
    };
};

pub const AddKeyReplicationRegionsOutput = struct {
    /// The updated key metadata after adding the replication regions.
    ///
    /// This includes the current state of the key and its replication
    /// configuration.
    key: ?Key = null,

    pub const json_field_names = .{
        .key = "Key",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddKeyReplicationRegionsInput, options: CallOptions) !AddKeyReplicationRegionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddKeyReplicationRegionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.AddKeyReplicationRegions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddKeyReplicationRegionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(AddKeyReplicationRegionsOutput, body, allocator);
}
