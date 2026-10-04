const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const EnableDefaultKeyReplicationRegionsInput = struct {
    /// The list of Amazon Web Services Regions to enable as default replication
    /// regions for the Amazon Web Services account for [Multi-Region key
    /// replication](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-multi-region-replication.html).
    ///
    /// New keys created in this account will automatically be replicated to these
    /// regions unless explicitly overridden during key creation.
    replication_regions: []const []const u8,

    pub const json_field_names = .{
        .replication_regions = "ReplicationRegions",
    };
};

pub const EnableDefaultKeyReplicationRegionsOutput = struct {
    /// The complete list of regions where default key replication is now enabled
    /// for the account.
    ///
    /// This includes both previously enabled regions and the newly added regions
    /// from this operation.
    enabled_replication_regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .enabled_replication_regions = "EnabledReplicationRegions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableDefaultKeyReplicationRegionsInput, options: CallOptions) !EnableDefaultKeyReplicationRegionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableDefaultKeyReplicationRegionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.EnableDefaultKeyReplicationRegions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableDefaultKeyReplicationRegionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(EnableDefaultKeyReplicationRegionsOutput, body, allocator);
}
