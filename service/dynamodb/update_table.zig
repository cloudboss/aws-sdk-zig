const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeDefinition = @import("attribute_definition.zig").AttributeDefinition;
const BillingMode = @import("billing_mode.zig").BillingMode;
const GlobalSecondaryIndexUpdate = @import("global_secondary_index_update.zig").GlobalSecondaryIndexUpdate;
const GlobalTableWitnessGroupUpdate = @import("global_table_witness_group_update.zig").GlobalTableWitnessGroupUpdate;
const MultiRegionConsistency = @import("multi_region_consistency.zig").MultiRegionConsistency;
const OnDemandThroughput = @import("on_demand_throughput.zig").OnDemandThroughput;
const ProvisionedThroughput = @import("provisioned_throughput.zig").ProvisionedThroughput;
const ReplicationGroupUpdate = @import("replication_group_update.zig").ReplicationGroupUpdate;
const SSESpecification = @import("sse_specification.zig").SSESpecification;
const StreamSpecification = @import("stream_specification.zig").StreamSpecification;
const TableClass = @import("table_class.zig").TableClass;
const WarmThroughput = @import("warm_throughput.zig").WarmThroughput;
const TableDescription = @import("table_description.zig").TableDescription;

pub const UpdateTableInput = struct {
    /// An array of attributes that describe the key schema for the table and
    /// indexes. If you
    /// are adding a new global secondary index to the table, `AttributeDefinitions`
    /// must include the key element(s) of the new index.
    attribute_definitions: ?[]const AttributeDefinition = null,

    /// Controls how you are charged for read and write throughput and how you
    /// manage
    /// capacity. When switching from pay-per-request to provisioned capacity,
    /// initial
    /// provisioned capacity values must be set. The initial provisioned capacity
    /// values are
    /// estimated based on the consumed read and write capacity of your table and
    /// global
    /// secondary indexes over the past 30 minutes.
    ///
    /// * `PAY_PER_REQUEST` - We recommend using `PAY_PER_REQUEST`
    /// for most DynamoDB workloads. `PAY_PER_REQUEST` sets the billing mode
    /// to [On-demand capacity
    /// mode](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/on-demand-capacity-mode.html).
    ///
    /// * `PROVISIONED` - We recommend using `PROVISIONED` for
    /// steady workloads with predictable growth where capacity requirements can be
    /// reliably forecasted. `PROVISIONED` sets the billing mode to [Provisioned
    /// capacity
    /// mode](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/provisioned-capacity-mode.html).
    billing_mode: ?BillingMode = null,

    /// Indicates whether deletion protection is to be enabled (true) or disabled
    /// (false) on
    /// the table.
    deletion_protection_enabled: ?bool = null,

    /// An array of one or more global secondary indexes for the table. For each
    /// index in the
    /// array, you can request one action:
    ///
    /// * `Create` - add a new global secondary index to the table.
    ///
    /// * `Update` - modify the provisioned throughput settings of an existing
    /// global secondary index.
    ///
    /// * `Delete` - remove a global secondary index from the table.
    ///
    /// You can create or delete only one global secondary index per `UpdateTable`
    /// operation.
    ///
    /// For more information, see [Managing Global
    /// Secondary
    /// Indexes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GSI.OnlineOps.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    global_secondary_index_updates: ?[]const GlobalSecondaryIndexUpdate = null,

    /// A list of witness updates for a MRSC global table. A witness provides a
    /// cost-effective
    /// alternative to a full replica in a MRSC global table by maintaining
    /// replicated change
    /// data written to global table replicas. You cannot perform read or write
    /// operations on a
    /// witness. For each witness, you can request one action:
    ///
    /// * `Create` - add a new witness to the global table.
    ///
    /// * `Delete` - remove a witness from the global table.
    ///
    /// You can create or delete only one witness per `UpdateTable`
    /// operation.
    ///
    /// For more information, see [Multi-Region strong consistency
    /// (MRSC)](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/V2globaltables_HowItWorks.html#V2globaltables_HowItWorks.consistency-modes) in the Amazon DynamoDB
    /// Developer Guide
    global_table_witness_updates: ?[]const GlobalTableWitnessGroupUpdate = null,

    /// Specifies the consistency mode for a new global table. This parameter is
    /// only valid
    /// when you create a global table by specifying one or more
    /// [Create](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ReplicationGroupUpdate.html#DDB-Type-ReplicationGroupUpdate-Create) actions in the [ReplicaUpdates](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_UpdateTable.html#DDB-UpdateTable-request-ReplicaUpdates) action list.
    ///
    /// You can specify one of the following consistency modes:
    ///
    /// * `EVENTUAL`: Configures a new global table for multi-Region eventual
    /// consistency (MREC). This is the default consistency mode for global
    /// tables.
    ///
    /// * `STRONG`: Configures a new global table for multi-Region strong
    /// consistency (MRSC).
    ///
    /// If you don't specify this field, the global table consistency mode defaults
    /// to
    /// `EVENTUAL`. For more information about global tables consistency modes,
    /// see [
    /// Consistency
    /// modes](https://docs.aws.amazon.com/V2globaltables_HowItWorks.html#V2globaltables_HowItWorks.consistency-modes) in DynamoDB developer guide.
    multi_region_consistency: ?MultiRegionConsistency = null,

    /// Updates the maximum number of read and write units for the specified table
    /// in
    /// on-demand capacity mode. If you use this parameter, you must specify
    /// `MaxReadRequestUnits`, `MaxWriteRequestUnits`, or both.
    on_demand_throughput: ?OnDemandThroughput = null,

    /// The new provisioned throughput settings for the specified table or index.
    provisioned_throughput: ?ProvisionedThroughput = null,

    /// A list of replica update actions (create, delete, or update) for the table.
    replica_updates: ?[]const ReplicationGroupUpdate = null,

    /// The new server-side encryption settings for the specified table.
    sse_specification: ?SSESpecification = null,

    /// Represents the DynamoDB Streams configuration for the table.
    ///
    /// You receive a `ValidationException` if you try to enable a stream on a
    /// table that already has a stream, or if you try to disable a stream on a
    /// table that
    /// doesn't have a stream.
    stream_specification: ?StreamSpecification = null,

    /// The table class of the table to be updated. Valid values are `STANDARD` and
    /// `STANDARD_INFREQUENT_ACCESS`.
    table_class: ?TableClass = null,

    /// The name of the table to be updated. You can also provide the Amazon
    /// Resource Name (ARN) of the table
    /// in this parameter.
    table_name: []const u8,

    /// Represents the warm throughput (in read units per second and write units per
    /// second)
    /// for updating a table.
    warm_throughput: ?WarmThroughput = null,

    pub const json_field_names = .{
        .attribute_definitions = "AttributeDefinitions",
        .billing_mode = "BillingMode",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .global_secondary_index_updates = "GlobalSecondaryIndexUpdates",
        .global_table_witness_updates = "GlobalTableWitnessUpdates",
        .multi_region_consistency = "MultiRegionConsistency",
        .on_demand_throughput = "OnDemandThroughput",
        .provisioned_throughput = "ProvisionedThroughput",
        .replica_updates = "ReplicaUpdates",
        .sse_specification = "SSESpecification",
        .stream_specification = "StreamSpecification",
        .table_class = "TableClass",
        .table_name = "TableName",
        .warm_throughput = "WarmThroughput",
    };
};

pub const UpdateTableOutput = struct {
    /// Represents the properties of the table.
    table_description: ?TableDescription = null,

    pub const json_field_names = .{
        .table_description = "TableDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTableInput, options: CallOptions) !UpdateTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "dynamodb");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.UpdateTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTableOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateTableOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BackupInUseException")) {
        return .{ .arena = arena, .kind = .{ .backup_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BackupNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .backup_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConditionalCheckFailedException")) {
        return .{ .arena = arena, .kind = .{ .conditional_check_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ContinuousBackupsUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .continuous_backups_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateItemException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_item_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExportConflictException")) {
        return .{ .arena = arena, .kind = .{ .export_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExportNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .export_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalTableAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .global_table_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalTableNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .global_table_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImportConflictException")) {
        return .{ .arena = arena, .kind = .{ .import_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImportNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .import_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IndexNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .index_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointException")) {
        return .{ .arena = arena, .kind = .{ .invalid_endpoint_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExportTimeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_export_time_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRestoreTimeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_restore_time_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ItemCollectionSizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .item_collection_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PointInTimeRecoveryUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .point_in_time_recovery_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedThroughputExceededException")) {
        return .{ .arena = arena, .kind = .{ .provisioned_throughput_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicaAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .replica_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicaNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .replica_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicatedWriteConflictException")) {
        return .{ .arena = arena, .kind = .{ .replicated_write_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .request_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "TableAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .table_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TableInUseException")) {
        return .{ .arena = arena, .kind = .{ .table_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TableNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .table_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransactionCanceledException")) {
        return .{ .arena = arena, .kind = .{ .transaction_canceled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransactionConflictException")) {
        return .{ .arena = arena, .kind = .{ .transaction_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransactionInProgressException")) {
        return .{ .arena = arena, .kind = .{ .transaction_in_progress_exception = .{
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
