const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *UpdateTableOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .table_description = "TableDescription",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: UpdateTableInput, options: Options) !UpdateTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "dynamodb");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "DynamoDB_20120810.UpdateTable");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateTableOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateTableOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";

    if (std.mem.eql(u8, error_code, "BackupInUseException")) {
        return .{ .backup_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "BackupNotFoundException")) {
        return .{ .backup_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ConditionalCheckFailedException")) {
        return .{ .conditional_check_failed_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ContinuousBackupsUnavailableException")) {
        return .{ .continuous_backups_unavailable_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateItemException")) {
        return .{ .duplicate_item_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ExportConflictException")) {
        return .{ .export_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ExportNotFoundException")) {
        return .{ .export_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "GlobalTableAlreadyExistsException")) {
        return .{ .global_table_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "GlobalTableNotFoundException")) {
        return .{ .global_table_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .idempotent_parameter_mismatch_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ImportConflictException")) {
        return .{ .import_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ImportNotFoundException")) {
        return .{ .import_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "IndexNotFoundException")) {
        return .{ .index_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .internal_server_error = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointException")) {
        return .{ .invalid_endpoint_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExportTimeException")) {
        return .{ .invalid_export_time_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRestoreTimeException")) {
        return .{ .invalid_restore_time_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ItemCollectionSizeLimitExceededException")) {
        return .{ .item_collection_size_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PointInTimeRecoveryUnavailableException")) {
        return .{ .point_in_time_recovery_unavailable_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFoundException")) {
        return .{ .policy_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedThroughputExceededException")) {
        return .{ .provisioned_throughput_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplicaAlreadyExistsException")) {
        return .{ .replica_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplicaNotFoundException")) {
        return .{ .replica_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplicatedWriteConflictException")) {
        return .{ .replicated_write_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceeded")) {
        return .{ .request_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .resource_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TableAlreadyExistsException")) {
        return .{ .table_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TableInUseException")) {
        return .{ .table_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TableNotFoundException")) {
        return .{ .table_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .throttling_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TransactionCanceledException")) {
        return .{ .transaction_canceled_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TransactionConflictException")) {
        return .{ .transaction_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TransactionInProgressException")) {
        return .{ .transaction_in_progress_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = "",
        .http_status = status,
    } };
}
