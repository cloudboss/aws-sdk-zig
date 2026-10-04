const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicationStatusType = @import("replication_status_type.zig").ReplicationStatusType;

pub const RemoveRegionsFromReplicationInput = struct {
    /// The Regions of the replicas to remove.
    remove_replica_regions: []const []const u8,

    /// The ARN or name of the secret.
    secret_id: []const u8,

    pub const json_field_names = .{
        .remove_replica_regions = "RemoveReplicaRegions",
        .secret_id = "SecretId",
    };
};

pub const RemoveRegionsFromReplicationOutput = struct {
    /// The ARN of the primary secret.
    arn: ?[]const u8 = null,

    /// The status of replicas for this secret after you remove Regions.
    replication_status: ?[]const ReplicationStatusType = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .replication_status = "ReplicationStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemoveRegionsFromReplicationInput, options: CallOptions) !RemoveRegionsFromReplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "secretsmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RemoveRegionsFromReplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("secretsmanager", "Secrets Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "secretsmanager.RemoveRegionsFromReplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemoveRegionsFromReplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RemoveRegionsFromReplicationOutput, body, allocator);
}
