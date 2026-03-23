const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AutoScalingSpecification = @import("auto_scaling_specification.zig").AutoScalingSpecification;
const CapacitySpecification = @import("capacity_specification.zig").CapacitySpecification;
const CdcSpecification = @import("cdc_specification.zig").CdcSpecification;
const ClientSideTimestamps = @import("client_side_timestamps.zig").ClientSideTimestamps;
const Comment = @import("comment.zig").Comment;
const EncryptionSpecification = @import("encryption_specification.zig").EncryptionSpecification;
const PointInTimeRecovery = @import("point_in_time_recovery.zig").PointInTimeRecovery;
const ReplicaSpecification = @import("replica_specification.zig").ReplicaSpecification;
const SchemaDefinition = @import("schema_definition.zig").SchemaDefinition;
const Tag = @import("tag.zig").Tag;
const TimeToLive = @import("time_to_live.zig").TimeToLive;
const WarmThroughputSpecification = @import("warm_throughput_specification.zig").WarmThroughputSpecification;

pub const CreateTableInput = struct {
    /// The optional auto scaling settings for a table in provisioned capacity mode.
    /// Specifies if the service can manage throughput capacity automatically on
    /// your behalf.
    ///
    /// Auto scaling helps you provision throughput capacity for variable workloads
    /// efficiently by increasing and decreasing your table's read and write
    /// capacity automatically in response to application traffic. For more
    /// information, see [Managing throughput capacity automatically with Amazon
    /// Keyspaces auto
    /// scaling](https://docs.aws.amazon.com/keyspaces/latest/devguide/autoscaling.html) in the *Amazon Keyspaces Developer Guide*.
    ///
    /// By default, auto scaling is disabled for a table.
    auto_scaling_specification: ?AutoScalingSpecification = null,

    /// Specifies the read/write throughput capacity mode for the table. The options
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

    /// This parameter allows to enter a description of the table.
    comment: ?Comment = null,

    /// The default Time to Live setting in seconds for the table.
    ///
    /// For more information, see [Setting the default TTL value for a
    /// table](https://docs.aws.amazon.com/keyspaces/latest/devguide/TTL-how-it-works.html#ttl-howitworks_default_ttl) in the *Amazon Keyspaces Developer Guide*.
    default_time_to_live: ?i32 = null,

    /// Specifies how the encryption key for encryption at rest is managed for the
    /// table. You can choose one of the following KMS key (KMS key):
    ///
    /// * `type:AWS_OWNED_KMS_KEY` - This key is owned by Amazon Keyspaces.
    /// * `type:CUSTOMER_MANAGED_KMS_KEY` - This key is stored in your account and
    ///   is created, owned, and managed by you. This option requires the
    ///   `kms_key_identifier` of the KMS key in Amazon Resource Name (ARN) format
    ///   as input.
    ///
    /// The default is `type:AWS_OWNED_KMS_KEY`.
    ///
    /// For more information, see [Encryption at
    /// rest](https://docs.aws.amazon.com/keyspaces/latest/devguide/EncryptionAtRest.html) in the *Amazon Keyspaces Developer Guide*.
    encryption_specification: ?EncryptionSpecification = null,

    /// The name of the keyspace that the table is going to be created in.
    keyspace_name: []const u8,

    /// Specifies if `pointInTimeRecovery` is enabled or disabled for the table. The
    /// options are:
    ///
    /// * `status=ENABLED`
    /// * `status=DISABLED`
    ///
    /// If it's not specified, the default is `status=DISABLED`.
    ///
    /// For more information, see [Point-in-time
    /// recovery](https://docs.aws.amazon.com/keyspaces/latest/devguide/PointInTimeRecovery.html) in the *Amazon Keyspaces Developer Guide*.
    point_in_time_recovery: ?PointInTimeRecovery = null,

    /// The optional Amazon Web Services Region specific settings of a multi-Region
    /// table. These settings overwrite the general settings of the table for the
    /// specified Region.
    ///
    /// For a multi-Region table in provisioned capacity mode, you can configure the
    /// table's read capacity differently for each Region's replica. The write
    /// capacity, however, remains synchronized between all replicas to ensure that
    /// there's enough capacity to replicate writes across all Regions. To define
    /// the read capacity for a table replica in a specific Region, you can do so by
    /// configuring the following parameters.
    ///
    /// * `region`: The Region where these settings are applied. (Required)
    /// * `readCapacityUnits`: The provisioned read capacity units. (Optional)
    /// * `readCapacityAutoScaling`: The read capacity auto scaling settings for the
    ///   table. (Optional)
    replica_specifications: ?[]const ReplicaSpecification = null,

    /// The `schemaDefinition` consists of the following parameters.
    ///
    /// For each column to be created:
    ///
    /// * `name` - The name of the column.
    /// * `type` - An Amazon Keyspaces data type. For more information, see [Data
    ///   types](https://docs.aws.amazon.com/keyspaces/latest/devguide/cql.elements.html#cql.data-types) in the *Amazon Keyspaces Developer Guide*.
    ///
    /// The primary key of the table consists of the following columns:
    ///
    /// * `partitionKeys` - The partition key can be a single column, or it can be a
    ///   compound value composed of two or more columns. The partition key portion
    ///   of the primary key is required and determines how Amazon Keyspaces stores
    ///   your data.
    /// * `name` - The name of each partition key column.
    /// * `clusteringKeys` - The optional clustering column portion of your primary
    ///   key determines how the data is clustered and sorted within each partition.
    /// * `name` - The name of the clustering column.
    /// * `orderBy` - Sets the ascendant (`ASC`) or descendant (`DESC`) order
    ///   modifier.
    ///
    /// To define a column as static use `staticColumns` - Static columns store
    /// values that are shared by all rows in the same partition:
    /// * `name` - The name of the column.
    /// * `type` - An Amazon Keyspaces data type.
    schema_definition: SchemaDefinition,

    /// The name of the table.
    table_name: []const u8,

    /// A list of key-value pair tags to be attached to the resource.
    ///
    /// For more information, see [Adding tags and labels to Amazon Keyspaces
    /// resources](https://docs.aws.amazon.com/keyspaces/latest/devguide/tagging-keyspaces.html) in the *Amazon Keyspaces Developer Guide*.
    tags: ?[]const Tag = null,

    /// Enables Time to Live custom settings for the table. The options are:
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

    /// Specifies the warm throughput settings for the table. Pre-warming a table
    /// helps you avoid capacity exceeded exceptions by pre-provisioning read and
    /// write capacity units to reduce cold start latency when your table receives
    /// traffic.
    ///
    /// For more information about pre-warming in Amazon Keyspaces, see [Pre-warm a
    /// table in Amazon
    /// Keyspaces](https://docs.aws.amazon.com/keyspaces/latest/devguide/warm-throughput.html) in the *Amazon Keyspaces Developer Guide*.
    warm_throughput_specification: ?WarmThroughputSpecification = null,

    pub const json_field_names = .{
        .auto_scaling_specification = "autoScalingSpecification",
        .capacity_specification = "capacitySpecification",
        .cdc_specification = "cdcSpecification",
        .client_side_timestamps = "clientSideTimestamps",
        .comment = "comment",
        .default_time_to_live = "defaultTimeToLive",
        .encryption_specification = "encryptionSpecification",
        .keyspace_name = "keyspaceName",
        .point_in_time_recovery = "pointInTimeRecovery",
        .replica_specifications = "replicaSpecifications",
        .schema_definition = "schemaDefinition",
        .table_name = "tableName",
        .tags = "tags",
        .ttl = "ttl",
        .warm_throughput_specification = "warmThroughputSpecification",
    };
};

pub const CreateTableOutput = struct {
    /// The unique identifier of the table in the format of an Amazon Resource Name
    /// (ARN).
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTableInput, options: CallOptions) !CreateTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cassandra");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cassandra", "Keyspaces", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "KeyspacesService.CreateTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTableOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateTableOutput, body, allocator);
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
