const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CapacitySpecificationSummary = @import("capacity_specification_summary.zig").CapacitySpecificationSummary;
const CdcSpecificationSummary = @import("cdc_specification_summary.zig").CdcSpecificationSummary;
const ClientSideTimestamps = @import("client_side_timestamps.zig").ClientSideTimestamps;
const Comment = @import("comment.zig").Comment;
const EncryptionSpecification = @import("encryption_specification.zig").EncryptionSpecification;
const PointInTimeRecoverySummary = @import("point_in_time_recovery_summary.zig").PointInTimeRecoverySummary;
const ReplicaSpecificationSummary = @import("replica_specification_summary.zig").ReplicaSpecificationSummary;
const SchemaDefinition = @import("schema_definition.zig").SchemaDefinition;
const TableStatus = @import("table_status.zig").TableStatus;
const TimeToLive = @import("time_to_live.zig").TimeToLive;
const WarmThroughputSpecificationSummary = @import("warm_throughput_specification_summary.zig").WarmThroughputSpecificationSummary;

pub const GetTableInput = struct {
    /// The name of the keyspace that the table is stored in.
    keyspace_name: []const u8,

    /// The name of the table.
    table_name: []const u8,

    pub const json_field_names = .{
        .keyspace_name = "keyspaceName",
        .table_name = "tableName",
    };
};

pub const GetTableOutput = struct {
    /// The read/write throughput capacity mode for a table. The options are:
    ///
    /// * `throughputMode:PAY_PER_REQUEST`
    /// * `throughputMode:PROVISIONED`
    capacity_specification: ?CapacitySpecificationSummary = null,

    /// The CDC stream settings of the table.
    cdc_specification: ?CdcSpecificationSummary = null,

    /// The client-side timestamps setting of the table.
    client_side_timestamps: ?ClientSideTimestamps = null,

    /// The the description of the specified table.
    comment: ?Comment = null,

    /// The creation timestamp of the specified table.
    creation_timestamp: ?i64 = null,

    /// The default Time to Live settings in seconds of the specified table.
    default_time_to_live: ?i32 = null,

    /// The encryption settings of the specified table.
    encryption_specification: ?EncryptionSpecification = null,

    /// The name of the keyspace that the specified table is stored in.
    keyspace_name: []const u8,

    /// The Amazon Resource Name (ARN) of the stream.
    latest_stream_arn: ?[]const u8 = null,

    /// The point-in-time recovery status of the specified table.
    point_in_time_recovery: ?PointInTimeRecoverySummary = null,

    /// Returns the Amazon Web Services Region specific settings of all Regions a
    /// multi-Region table is replicated in.
    replica_specifications: ?[]const ReplicaSpecificationSummary = null,

    /// The Amazon Resource Name (ARN) of the specified table.
    resource_arn: []const u8,

    /// The schema definition of the specified table.
    schema_definition: ?SchemaDefinition = null,

    /// The current status of the specified table.
    status: ?TableStatus = null,

    /// The name of the specified table.
    table_name: []const u8,

    /// The custom Time to Live settings of the specified table.
    ttl: ?TimeToLive = null,

    /// The warm throughput settings for the table, including the current status and
    /// configured read and write capacity units.
    warm_throughput_specification: ?WarmThroughputSpecificationSummary = null,

    pub const json_field_names = .{
        .capacity_specification = "capacitySpecification",
        .cdc_specification = "cdcSpecification",
        .client_side_timestamps = "clientSideTimestamps",
        .comment = "comment",
        .creation_timestamp = "creationTimestamp",
        .default_time_to_live = "defaultTimeToLive",
        .encryption_specification = "encryptionSpecification",
        .keyspace_name = "keyspaceName",
        .latest_stream_arn = "latestStreamArn",
        .point_in_time_recovery = "pointInTimeRecovery",
        .replica_specifications = "replicaSpecifications",
        .resource_arn = "resourceArn",
        .schema_definition = "schemaDefinition",
        .status = "status",
        .table_name = "tableName",
        .ttl = "ttl",
        .warm_throughput_specification = "warmThroughputSpecification",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTableInput, options: CallOptions) !GetTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "keyspaces");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("keyspaces", "Keyspaces", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "KeyspacesService.GetTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTableOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetTableOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
