const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicationInstance = @import("replication_instance.zig").ReplicationInstance;

pub const RebootReplicationInstanceInput = struct {
    /// If this parameter is `true`, the reboot is conducted through a Multi-AZ
    /// failover. If the instance isn't configured for Multi-AZ, then you can't
    /// specify
    /// `true`. ( `--force-planned-failover` and
    /// `--force-failover` can't both be set to `true`.)
    force_failover: ?bool = null,

    /// If this parameter is `true`, the reboot is conducted through a planned
    /// Multi-AZ failover where resources are released and cleaned up prior to
    /// conducting the
    /// failover. If the instance isn''t configured for Multi-AZ, then you can't
    /// specify
    /// `true`. ( `--force-planned-failover` and
    /// `--force-failover` can't both be set to `true`.)
    force_planned_failover: ?bool = null,

    /// The Amazon Resource Name (ARN) of the replication instance.
    replication_instance_arn: []const u8,

    pub const json_field_names = .{
        .force_failover = "ForceFailover",
        .force_planned_failover = "ForcePlannedFailover",
        .replication_instance_arn = "ReplicationInstanceArn",
    };
};

pub const RebootReplicationInstanceOutput = struct {
    /// The replication instance that is being rebooted.
    replication_instance: ?ReplicationInstance = null,

    pub const json_field_names = .{
        .replication_instance = "ReplicationInstance",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RebootReplicationInstanceInput, options: CallOptions) !RebootReplicationInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RebootReplicationInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.RebootReplicationInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RebootReplicationInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RebootReplicationInstanceOutput, body, allocator);
}
