const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Key = @import("key.zig").Key;

pub const RemoveKeyReplicationRegionsInput = struct {
    /// The key identifier (ARN or alias) of the key from which to remove
    /// replication regions.
    ///
    /// This key must exist and have replication enabled in the specified regions.
    key_identifier: []const u8,

    /// The list of Amazon Web Services Regions to remove from the key's replication
    /// configuration.
    ///
    /// The key will no longer be available for cryptographic operations in these
    /// regions after removal. Ensure no active operations depend on the key in
    /// these regions before removal.
    replication_regions: []const []const u8,

    pub const json_field_names = .{
        .key_identifier = "KeyIdentifier",
        .replication_regions = "ReplicationRegions",
    };
};

pub const RemoveKeyReplicationRegionsOutput = struct {
    /// The updated key metadata after removing the replication regions.
    ///
    /// This reflects the current state of the key and its updated replication
    /// configuration.
    key: ?Key = null,

    pub const json_field_names = .{
        .key = "Key",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemoveKeyReplicationRegionsInput, options: CallOptions) !RemoveKeyReplicationRegionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RemoveKeyReplicationRegionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.RemoveKeyReplicationRegions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemoveKeyReplicationRegionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(RemoveKeyReplicationRegionsOutput, body, allocator);
}
