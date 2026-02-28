const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ColumnDefinition = @import("column_definition.zig").ColumnDefinition;
const AutoScalingSpecification = @import("auto_scaling_specification.zig").AutoScalingSpecification;
const CapacitySpecification = @import("capacity_specification.zig").CapacitySpecification;
const CdcSpecification = @import("cdc_specification.zig").CdcSpecification;
const ClientSideTimestamps = @import("client_side_timestamps.zig").ClientSideTimestamps;
const EncryptionSpecification = @import("encryption_specification.zig").EncryptionSpecification;
const PointInTimeRecovery = @import("point_in_time_recovery.zig").PointInTimeRecovery;
const ReplicaSpecification = @import("replica_specification.zig").ReplicaSpecification;
const TimeToLive = @import("time_to_live.zig").TimeToLive;
const WarmThroughputSpecification = @import("warm_throughput_specification.zig").WarmThroughputSpecification;

pub const UpdateTableInput = struct {
    /// For each column to be added to the specified table:
    ///
    /// * `name` - The name of the column.
    /// * `type` - An Amazon Keyspaces data type. For more information, see [Data
    ///   types](https://docs.aws.amazon.com/keyspaces/latest/devguide/cql.elements.html#cql.data-types) in the *Amazon Keyspaces Developer Guide*.
    add_columns: ?[]const ColumnDefinition = null,

    /// The optional auto scaling settings to update for a table in provisioned
    /// capacity mode. Specifies if the service can manage throughput capacity of a
    /// provisioned table automatically on your behalf. Amazon Keyspaces auto
    /// scaling helps you provision throughput capacity for variable workloads
    /// efficiently by increasing and decreasing your table's read and write
    /// capacity automatically in response to application traffic.
    ///
    /// If auto scaling is already enabled for the table, you can use `UpdateTable`
    /// to update the minimum and maximum values or the auto scaling policy settings
    /// independently.
    ///
    /// For more information, see [Managing throughput capacity automatically with
    /// Amazon Keyspaces auto
    /// scaling](https://docs.aws.amazon.com/keyspaces/latest/devguide/autoscaling.html) in the *Amazon Keyspaces Developer Guide*.
    auto_scaling_specification: ?AutoScalingSpecification = null,

    /// Modifies the read/write throughput capacity mode for the table. The options
    /// are:
    ///
    /// * `throughputMode:PAY_PER_REQUEST` and
    /// * `throughputMode:PROVISIONED` - Provisioned capacity mode requires
    ///   `readCapacityUnits` and `writeCapacityUnits` as input.
    ///
    /// The default is `throughput_mode:PAY_PER_REQUEST`.
    ///
    /// For more information, see [Read/write capacity
    /// modes](https://docs.aws.amazon.com/keyspaces/latest/devguide/ReadWriteCapacityMode.html) in the *Amazon Keyspaces Developer Guide*.
    capacity_specification: ?CapacitySpecification = null,

    /// The CDC stream settings of the table.
    cdc_specification: ?CdcSpecification = null,

    /// Enables client-side timestamps for the table. By default, the setting is
    /// disabled. You can enable client-side timestamps with the following option:
    ///
    /// * `status: "enabled"`
    ///
    /// Once client-side timestamps are enabled for a table, this setting cannot be
    /// disabled.
    client_side_timestamps: ?ClientSideTimestamps = null,

    /// The default Time to Live setting in seconds for the table.
    ///
    /// For more information, see [Setting the default TTL value for a
    /// table](https://docs.aws.amazon.com/keyspaces/latest/devguide/TTL-how-it-works.html#ttl-howitworks_default_ttl) in the *Amazon Keyspaces Developer Guide*.
    default_time_to_live: ?i32 = null,

    /// Modifies the encryption settings of the table. You can choose one of the
    /// following KMS key (KMS key):
    ///
    /// * `type:AWS_OWNED_KMS_KEY` - This key is owned by Amazon Keyspaces.
    /// * `type:CUSTOMER_MANAGED_KMS_KEY` - This key is stored in your account and
    ///   is created, owned, and managed by you. This option requires the
    ///   `kms_key_identifier` of the KMS key in Amazon Resource Name (ARN) format
    ///   as input.
    ///
    /// The default is `AWS_OWNED_KMS_KEY`.
    ///
    /// For more information, see [Encryption at
    /// rest](https://docs.aws.amazon.com/keyspaces/latest/devguide/EncryptionAtRest.html) in the *Amazon Keyspaces Developer Guide*.
    encryption_specification: ?EncryptionSpecification = null,

    /// The name of the keyspace the specified table is stored in.
    keyspace_name: []const u8,

    /// Modifies the `pointInTimeRecovery` settings of the table. The options are:
    ///
    /// * `status=ENABLED`
    /// * `status=DISABLED`
    ///
    /// If it's not specified, the default is `status=DISABLED`.
    ///
    /// For more information, see [Point-in-time
    /// recovery](https://docs.aws.amazon.com/keyspaces/latest/devguide/PointInTimeRecovery.html) in the *Amazon Keyspaces Developer Guide*.
    point_in_time_recovery: ?PointInTimeRecovery = null,

    /// The Region specific settings of a multi-Regional table.
    replica_specifications: ?[]const ReplicaSpecification = null,

    /// The name of the table.
    table_name: []const u8,

    /// Modifies Time to Live custom settings for the table. The options are:
    ///
    /// * `status:enabled`
    /// * `status:disabled`
    ///
    /// The default is `status:disabled`. After `ttl` is enabled, you can't disable
    /// it for the table.
    ///
    /// For more information, see [Expiring data by using Amazon Keyspaces Time to
    /// Live (TTL)](https://docs.aws.amazon.com/keyspaces/latest/devguide/TTL.html)
    /// in the *Amazon Keyspaces Developer Guide*.
    ttl: ?TimeToLive = null,

    /// Modifies the warm throughput settings for the table. You can update the read
    /// and write capacity units to adjust the pre-provisioned throughput.
    warm_throughput_specification: ?WarmThroughputSpecification = null,

    pub const json_field_names = .{
        .add_columns = "addColumns",
        .auto_scaling_specification = "autoScalingSpecification",
        .capacity_specification = "capacitySpecification",
        .cdc_specification = "cdcSpecification",
        .client_side_timestamps = "clientSideTimestamps",
        .default_time_to_live = "defaultTimeToLive",
        .encryption_specification = "encryptionSpecification",
        .keyspace_name = "keyspaceName",
        .point_in_time_recovery = "pointInTimeRecovery",
        .replica_specifications = "replicaSpecifications",
        .table_name = "tableName",
        .ttl = "ttl",
        .warm_throughput_specification = "warmThroughputSpecification",
    };
};

pub const UpdateTableOutput = struct {
    /// The Amazon Resource Name (ARN) of the modified table.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTableInput, options: Options) !UpdateTableOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("keyspaces", "Keyspaces", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "KeyspacesService.UpdateTable");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateTableOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateTableOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
