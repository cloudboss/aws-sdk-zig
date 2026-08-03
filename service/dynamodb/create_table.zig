const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const AttributeDefinition = @import("attribute_definition.zig").AttributeDefinition;
const BillingMode = @import("billing_mode.zig").BillingMode;
const GlobalSecondaryIndex = @import("global_secondary_index.zig").GlobalSecondaryIndex;
const GlobalTableSettingsReplicationMode = @import("global_table_settings_replication_mode.zig").GlobalTableSettingsReplicationMode;
const KeySchemaElement = @import("key_schema_element.zig").KeySchemaElement;
const LocalSecondaryIndex = @import("local_secondary_index.zig").LocalSecondaryIndex;
const OnDemandThroughput = @import("on_demand_throughput.zig").OnDemandThroughput;
const ProvisionedThroughput = @import("provisioned_throughput.zig").ProvisionedThroughput;
const SSESpecification = @import("sse_specification.zig").SSESpecification;
const StreamSpecification = @import("stream_specification.zig").StreamSpecification;
const TableClass = @import("table_class.zig").TableClass;
const Tag = @import("tag.zig").Tag;
const WarmThroughput = @import("warm_throughput.zig").WarmThroughput;
const TableDescription = @import("table_description.zig").TableDescription;

pub const CreateTableInput = struct {
    /// An array of attributes that describe the key schema for the table and
    /// indexes.
    attribute_definitions: ?[]const AttributeDefinition = null,

    /// Controls how you are charged for read and write throughput and how you
    /// manage
    /// capacity. This setting can be changed later.
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

    /// One or more global secondary indexes (the maximum is 20) to be created on
    /// the table.
    /// Each global secondary index in the array includes the following:
    ///
    /// * `IndexName` - The name of the global secondary index. Must be unique
    /// only for this table.
    ///
    /// * `KeySchema` - Specifies the key schema for the global secondary
    /// index. Each global secondary index supports up to 4 partition keys and up to
    /// 4 sort keys.
    ///
    /// * `Projection` - Specifies attributes that are copied (projected) from
    /// the table into the index. These are in addition to the primary key
    /// attributes
    /// and index key attributes, which are automatically projected. Each attribute
    /// specification is composed of:
    ///
    /// * `ProjectionType` - One of the following:
    ///
    /// * `KEYS_ONLY` - Only the index and primary keys are
    /// projected into the index.
    ///
    /// * `INCLUDE` - Only the specified table attributes are
    /// projected into the index. The list of projected attributes is in
    /// `NonKeyAttributes`.
    ///
    /// * `ALL` - All of the table attributes are projected
    /// into the index.
    ///
    /// * `NonKeyAttributes` - A list of one or more non-key attribute
    /// names that are projected into the secondary index. The total count of
    /// attributes provided in `NonKeyAttributes`, summed across all
    /// of the secondary indexes, must not exceed 100. If you project the same
    /// attribute into two different indexes, this counts as two distinct
    /// attributes when determining the total. This limit only applies when you
    /// specify the ProjectionType of `INCLUDE`. You still can
    /// specify the ProjectionType of `ALL` to project all attributes
    /// from the source table, even if the table has more than 100
    /// attributes.
    ///
    /// * `ProvisionedThroughput` - The provisioned throughput settings for the
    /// global secondary index, consisting of read and write capacity units.
    global_secondary_indexes: ?[]const GlobalSecondaryIndex = null,

    /// Controls the settings synchronization mode for the global table. For
    /// multi-account global tables,
    /// this parameter is required and the only supported value is ENABLED. For
    /// same-account global tables,
    /// this parameter is set to ENABLED_WITH_OVERRIDES.
    global_table_settings_replication_mode: ?GlobalTableSettingsReplicationMode = null,

    /// The Amazon Resource Name (ARN) of the source table used for the creation
    /// of a multi-account global table.
    global_table_source_arn: ?[]const u8 = null,

    /// Specifies the attributes that make up the primary key for a table or an
    /// index. The
    /// attributes in `KeySchema` must also be defined in the
    /// `AttributeDefinitions` array. For more information, see [Data
    /// Model](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DataModel.html) in the *Amazon DynamoDB Developer Guide*.
    ///
    /// Each `KeySchemaElement` in the array is composed of:
    ///
    /// * `AttributeName` - The name of this key attribute.
    ///
    /// * `KeyType` - The role that the key attribute will assume:
    ///
    /// * `HASH` - partition key
    ///
    /// * `RANGE` - sort key
    ///
    /// The partition key of an item is also known as its *hash
    /// attribute*. The term "hash attribute" derives from the DynamoDB usage
    /// of an internal hash function to evenly distribute data items across
    /// partitions,
    /// based on their partition key values.
    ///
    /// The sort key of an item is also known as its *range attribute*.
    /// The term "range attribute" derives from the way DynamoDB stores items with
    /// the same
    /// partition key physically close together, in sorted order by the sort key
    /// value.
    ///
    /// For a simple primary key (partition key), you must provide exactly one
    /// element with a
    /// `KeyType` of `HASH`.
    ///
    /// For a composite primary key (partition key and sort key), you must provide
    /// exactly two
    /// elements, in this order: The first element must have a `KeyType` of
    /// `HASH`, and the second element must have a `KeyType` of
    /// `RANGE`.
    ///
    /// For more information, see [Working with
    /// Tables](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#WorkingWithTables.primary.key) in the *Amazon DynamoDB Developer
    /// Guide*.
    key_schema: ?[]const KeySchemaElement = null,

    /// One or more local secondary indexes (the maximum is 5) to be created on the
    /// table.
    /// Each index is scoped to a given partition key value. There is a 10 GB size
    /// limit per
    /// partition key value; otherwise, the size of a local secondary index is
    /// unconstrained.
    ///
    /// Each local secondary index in the array includes the following:
    ///
    /// * `IndexName` - The name of the local secondary index. Must be unique
    /// only for this table.
    ///
    /// * `KeySchema` - Specifies the key schema for the local secondary index.
    /// The key schema must begin with the same partition key as the table.
    ///
    /// * `Projection` - Specifies attributes that are copied (projected) from
    /// the table into the index. These are in addition to the primary key
    /// attributes
    /// and index key attributes, which are automatically projected. Each attribute
    /// specification is composed of:
    ///
    /// * `ProjectionType` - One of the following:
    ///
    /// * `KEYS_ONLY` - Only the index and primary keys are
    /// projected into the index.
    ///
    /// * `INCLUDE` - Only the specified table attributes are
    /// projected into the index. The list of projected attributes is in
    /// `NonKeyAttributes`.
    ///
    /// * `ALL` - All of the table attributes are projected
    /// into the index.
    ///
    /// * `NonKeyAttributes` - A list of one or more non-key attribute
    /// names that are projected into the secondary index. The total count of
    /// attributes provided in `NonKeyAttributes`, summed across all
    /// of the secondary indexes, must not exceed 100. If you project the same
    /// attribute into two different indexes, this counts as two distinct
    /// attributes when determining the total. This limit only applies when you
    /// specify the ProjectionType of `INCLUDE`. You still can
    /// specify the ProjectionType of `ALL` to project all attributes
    /// from the source table, even if the table has more than 100
    /// attributes.
    local_secondary_indexes: ?[]const LocalSecondaryIndex = null,

    /// Sets the maximum number of read and write units for the specified table in
    /// on-demand
    /// capacity mode. If you use this parameter, you must specify
    /// `MaxReadRequestUnits`, `MaxWriteRequestUnits`, or both.
    on_demand_throughput: ?OnDemandThroughput = null,

    /// Represents the provisioned throughput settings for a specified table or
    /// index. The
    /// settings can be modified using the `UpdateTable` operation.
    ///
    /// If you set BillingMode as `PROVISIONED`, you must specify this property.
    /// If you set BillingMode as `PAY_PER_REQUEST`, you cannot specify this
    /// property.
    ///
    /// For current minimum and maximum provisioned throughput values, see [Service,
    /// Account, and Table
    /// Quotas](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    provisioned_throughput: ?ProvisionedThroughput = null,

    /// An Amazon Web Services resource-based policy document in JSON format that
    /// will be
    /// attached to the table.
    ///
    /// When you attach a resource-based policy while creating a table, the policy
    /// application
    /// is *strongly consistent*.
    ///
    /// The maximum size supported for a resource-based policy document is 20 KB.
    /// DynamoDB counts whitespaces when calculating the size of a policy against
    /// this
    /// limit. For a full list of all considerations that apply for resource-based
    /// policies, see
    /// [Resource-based
    /// policy
    /// considerations](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/rbac-considerations.html).
    ///
    /// You need to specify the `CreateTable` and
    /// `PutResourcePolicy`
    /// IAM actions for authorizing a user to create a table with a
    /// resource-based policy.
    resource_policy: ?[]const u8 = null,

    /// Represents the settings used to enable server-side encryption.
    sse_specification: ?SSESpecification = null,

    /// The settings for DynamoDB Streams on the table. These settings consist of:
    ///
    /// * `StreamEnabled` - Indicates whether DynamoDB Streams is to be enabled
    /// (true) or disabled (false).
    ///
    /// * `StreamViewType` - When an item in the table is modified,
    /// `StreamViewType` determines what information is written to the
    /// table's stream. Valid values for `StreamViewType` are:
    ///
    /// * `KEYS_ONLY` - Only the key attributes of the modified item
    /// are written to the stream.
    ///
    /// * `NEW_IMAGE` - The entire item, as it appears after it was
    /// modified, is written to the stream.
    ///
    /// * `OLD_IMAGE` - The entire item, as it appeared before it was
    /// modified, is written to the stream.
    ///
    /// * `NEW_AND_OLD_IMAGES` - Both the new and the old item images
    /// of the item are written to the stream.
    stream_specification: ?StreamSpecification = null,

    /// The table class of the new table. Valid values are `STANDARD` and
    /// `STANDARD_INFREQUENT_ACCESS`.
    table_class: ?TableClass = null,

    /// The name of the table to create. You can also provide the Amazon Resource
    /// Name (ARN) of the table in
    /// this parameter.
    table_name: []const u8,

    /// A list of key-value pairs to label the table. For more information, see
    /// [Tagging
    /// for
    /// DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tagging.html).
    tags: ?[]const Tag = null,

    /// Represents the warm throughput (in read units per second and write units per
    /// second)
    /// for creating a table.
    warm_throughput: ?WarmThroughput = null,

    pub const json_field_names = .{
        .attribute_definitions = "AttributeDefinitions",
        .billing_mode = "BillingMode",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .global_secondary_indexes = "GlobalSecondaryIndexes",
        .global_table_settings_replication_mode = "GlobalTableSettingsReplicationMode",
        .global_table_source_arn = "GlobalTableSourceArn",
        .key_schema = "KeySchema",
        .local_secondary_indexes = "LocalSecondaryIndexes",
        .on_demand_throughput = "OnDemandThroughput",
        .provisioned_throughput = "ProvisionedThroughput",
        .resource_policy = "ResourcePolicy",
        .sse_specification = "SSESpecification",
        .stream_specification = "StreamSpecification",
        .table_class = "TableClass",
        .table_name = "TableName",
        .tags = "Tags",
        .warm_throughput = "WarmThroughput",
    };
};

pub const CreateTableOutput = struct {
    /// Represents the properties of the table.
    table_description: ?TableDescription = null,

    pub const json_field_names = .{
        .table_description = "TableDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTableInput, options: CallOptions) !CreateTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.CreateTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTableOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTableOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.BackupInUseException = aws.json.parseJsonObject(errors.BackupInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backup_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BackupNotFoundException")) {
        const parsed_error: ?errors.BackupNotFoundException = aws.json.parseJsonObject(errors.BackupNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backup_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConditionalCheckFailedException")) {
        const parsed_error: ?errors.ConditionalCheckFailedException = aws.json.parseJsonObject(errors.ConditionalCheckFailedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conditional_check_failed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ContinuousBackupsUnavailableException")) {
        const parsed_error: ?errors.ContinuousBackupsUnavailableException = aws.json.parseJsonObject(errors.ContinuousBackupsUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .continuous_backups_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateItemException")) {
        const parsed_error: ?errors.DuplicateItemException = aws.json.parseJsonObject(errors.DuplicateItemException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_item_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExportConflictException")) {
        const parsed_error: ?errors.ExportConflictException = aws.json.parseJsonObject(errors.ExportConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .export_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExportNotFoundException")) {
        const parsed_error: ?errors.ExportNotFoundException = aws.json.parseJsonObject(errors.ExportNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .export_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GlobalTableAlreadyExistsException")) {
        const parsed_error: ?errors.GlobalTableAlreadyExistsException = aws.json.parseJsonObject(errors.GlobalTableAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .global_table_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GlobalTableNotFoundException")) {
        const parsed_error: ?errors.GlobalTableNotFoundException = aws.json.parseJsonObject(errors.GlobalTableNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .global_table_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        const parsed_error: ?errors.IdempotentParameterMismatchException = aws.json.parseJsonObject(errors.IdempotentParameterMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ImportConflictException")) {
        const parsed_error: ?errors.ImportConflictException = aws.json.parseJsonObject(errors.ImportConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .import_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ImportNotFoundException")) {
        const parsed_error: ?errors.ImportNotFoundException = aws.json.parseJsonObject(errors.ImportNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .import_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IndexNotFoundException")) {
        const parsed_error: ?errors.IndexNotFoundException = aws.json.parseJsonObject(errors.IndexNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .index_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        const parsed_error: ?errors.InternalServerError = aws.json.parseJsonObject(errors.InternalServerError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointException")) {
        const parsed_error: ?errors.InvalidEndpointException = aws.json.parseJsonObject(errors.InvalidEndpointException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_endpoint_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidExportTimeException")) {
        const parsed_error: ?errors.InvalidExportTimeException = aws.json.parseJsonObject(errors.InvalidExportTimeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_export_time_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRestoreTimeException")) {
        const parsed_error: ?errors.InvalidRestoreTimeException = aws.json.parseJsonObject(errors.InvalidRestoreTimeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_restore_time_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ItemCollectionSizeLimitExceededException")) {
        const parsed_error: ?errors.ItemCollectionSizeLimitExceededException = aws.json.parseJsonObject(errors.ItemCollectionSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .item_collection_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PointInTimeRecoveryUnavailableException")) {
        const parsed_error: ?errors.PointInTimeRecoveryUnavailableException = aws.json.parseJsonObject(errors.PointInTimeRecoveryUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .point_in_time_recovery_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFoundException")) {
        const parsed_error: ?errors.PolicyNotFoundException = aws.json.parseJsonObject(errors.PolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ProvisionedThroughputExceededException")) {
        const parsed_error: ?errors.ProvisionedThroughputExceededException = aws.json.parseJsonObject(errors.ProvisionedThroughputExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .provisioned_throughput_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReplicaAlreadyExistsException")) {
        const parsed_error: ?errors.ReplicaAlreadyExistsException = aws.json.parseJsonObject(errors.ReplicaAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .replica_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReplicaNotFoundException")) {
        const parsed_error: ?errors.ReplicaNotFoundException = aws.json.parseJsonObject(errors.ReplicaNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .replica_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReplicatedWriteConflictException")) {
        const parsed_error: ?errors.ReplicatedWriteConflictException = aws.json.parseJsonObject(errors.ReplicatedWriteConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .replicated_write_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceeded")) {
        const parsed_error: ?errors.RequestLimitExceeded = aws.json.parseJsonObject(errors.RequestLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .request_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        const parsed_error: ?errors.ResourceInUseException = aws.json.parseJsonObject(errors.ResourceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TableAlreadyExistsException")) {
        const parsed_error: ?errors.TableAlreadyExistsException = aws.json.parseJsonObject(errors.TableAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .table_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TableInUseException")) {
        const parsed_error: ?errors.TableInUseException = aws.json.parseJsonObject(errors.TableInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .table_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TableNotFoundException")) {
        const parsed_error: ?errors.TableNotFoundException = aws.json.parseJsonObject(errors.TableNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .table_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TransactionCanceledException")) {
        const parsed_error: ?errors.TransactionCanceledException = aws.json.parseJsonObject(errors.TransactionCanceledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .transaction_canceled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TransactionConflictException")) {
        const parsed_error: ?errors.TransactionConflictException = aws.json.parseJsonObject(errors.TransactionConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .transaction_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TransactionInProgressException")) {
        const parsed_error: ?errors.TransactionInProgressException = aws.json.parseJsonObject(errors.TransactionInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .transaction_in_progress_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
