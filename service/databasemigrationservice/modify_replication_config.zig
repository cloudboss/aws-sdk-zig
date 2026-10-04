const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeConfig = @import("compute_config.zig").ComputeConfig;
const MigrationTypeValue = @import("migration_type_value.zig").MigrationTypeValue;
const ReplicationConfig = @import("replication_config.zig").ReplicationConfig;

pub const ModifyReplicationConfigInput = struct {
    /// Configuration parameters for provisioning an DMS Serverless replication.
    compute_config: ?ComputeConfig = null,

    /// The Amazon Resource Name of the replication to modify.
    replication_config_arn: []const u8,

    /// The new replication config to apply to the replication.
    replication_config_identifier: ?[]const u8 = null,

    /// The settings for the replication.
    replication_settings: ?[]const u8 = null,

    /// The type of replication.
    replication_type: ?MigrationTypeValue = null,

    /// The Amazon Resource Name (ARN) of the source endpoint for this DMS
    /// serverless
    /// replication configuration.
    source_endpoint_arn: ?[]const u8 = null,

    /// Additional settings for the replication.
    supplemental_settings: ?[]const u8 = null,

    /// Table mappings specified in the replication.
    table_mappings: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the target endpoint for this DMS
    /// serverless
    /// replication configuration.
    target_endpoint_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .compute_config = "ComputeConfig",
        .replication_config_arn = "ReplicationConfigArn",
        .replication_config_identifier = "ReplicationConfigIdentifier",
        .replication_settings = "ReplicationSettings",
        .replication_type = "ReplicationType",
        .source_endpoint_arn = "SourceEndpointArn",
        .supplemental_settings = "SupplementalSettings",
        .table_mappings = "TableMappings",
        .target_endpoint_arn = "TargetEndpointArn",
    };
};

pub const ModifyReplicationConfigOutput = struct {
    /// Information about the serverless replication config that was modified.
    replication_config: ?ReplicationConfig = null,

    pub const json_field_names = .{
        .replication_config = "ReplicationConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyReplicationConfigInput, options: CallOptions) !ModifyReplicationConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyReplicationConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.ModifyReplicationConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyReplicationConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ModifyReplicationConfigOutput, body, allocator);
}
