const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Replica = @import("replica.zig").Replica;
const GlobalTableDescription = @import("global_table_description.zig").GlobalTableDescription;

/// Creates a global table from an existing table. A global table creates a
/// replication
/// relationship between two or more DynamoDB tables with the same table name in
/// the
/// provided Regions.
///
/// **Important:**
///
/// This documentation is for version 2017.11.29 (Legacy) of global tables,
/// which should be avoided for new global tables. Customers should use [Global
/// Tables version 2019.11.21
/// (Current)](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GlobalTables.html) when possible, because it provides greater flexibility, higher efficiency, and consumes less write capacity than 2017.11.29 (Legacy).
///
/// To determine which version you're using, see [Determining the global table
/// version you are
/// using](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/globaltables.DetermineVersion.html). To update existing global tables from version 2017.11.29 (Legacy) to version 2019.11.21 (Current), see [Upgrading global tables](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/V2globaltables_upgrade.html).
///
/// If you want to add a new replica table to a global table, each of the
/// following
/// conditions must be true:
///
/// * The table must have the same primary key as all of the other replicas.
///
/// * The table must have the same name as all of the other replicas.
///
/// * The table must have DynamoDB Streams enabled, with the stream containing
///   both
/// the new and the old images of the item.
///
/// * None of the replica tables in the global table can contain any data.
///
/// If global secondary indexes are specified, then the following conditions
/// must also be
/// met:
///
/// * The global secondary indexes must have the same name.
///
/// * The global secondary indexes must have the same hash key and sort key (if
/// present).
///
/// If local secondary indexes are specified, then the following conditions must
/// also be
/// met:
///
/// * The local secondary indexes must have the same name.
///
/// * The local secondary indexes must have the same hash key and sort key (if
/// present).
///
/// **Important:**
///
/// Write capacity settings should be set consistently across your replica
/// tables and
/// secondary indexes. DynamoDB strongly recommends enabling auto scaling to
/// manage the
/// write capacity settings for all of your global tables replicas and indexes.
///
/// If you prefer to manage write capacity settings manually, you should
/// provision
/// equal replicated write capacity units to your replica tables. You should
/// also
/// provision equal replicated write capacity units to matching secondary
/// indexes across
/// your global table.
pub const CreateGlobalTableInput = struct {
    /// The global table name.
    global_table_name: []const u8,

    /// The Regions where the global table needs to be created.
    replication_group: []const Replica,

    pub const json_field_names = .{
        .global_table_name = "GlobalTableName",
        .replication_group = "ReplicationGroup",
    };
};

pub const CreateGlobalTableOutput = struct {
    /// Contains the details of the global table.
    global_table_description: ?GlobalTableDescription = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateGlobalTableOutput) void {
        _ = self;
    }

    pub const json_field_names = .{
        .global_table_description = "GlobalTableDescription",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateGlobalTableInput, options: Options) !CreateGlobalTableOutput {
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

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateGlobalTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("dynamodb", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "DynamoDB_20120810.CreateGlobalTable");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateGlobalTableOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{ .allocator = alloc };
    return aws.json.parseJsonObject(CreateGlobalTableOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = findJsonValue(body, "message") orelse findJsonValue(body, "Message") orelse "";

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

fn findJsonValue(json: []const u8, key: []const u8) ?[]const u8 {
    // Build search pattern: "key"
    var buf: [258]u8 = undefined;
    if (key.len + 2 > buf.len) return null;
    buf[0] = 0x22; // double-quote
    @memcpy(buf[1..][0..key.len], key);
    buf[key.len + 1] = 0x22; // double-quote
    const search = buf[0 .. key.len + 2];
    const key_start = std.mem.indexOf(u8, json, search) orelse return null;
    var pos = key_start + search.len;

    // Skip whitespace and colon
    while (pos < json.len) : (pos += 1) {
        if (json[pos] != ' ' and json[pos] != ':') break;
    }
    if (pos >= json.len) return null;

    if (json[pos] == 0x22) {
        const start = pos + 1;
        const end = std.mem.indexOfScalarPos(u8, json, start, 0x22) orelse return null;
        return json[start..end];
    }

    const start = pos;
    while (pos < json.len) : (pos += 1) {
        if (json[pos] == ',' or json[pos] == '}' or json[pos] == ' ') break;
    }
    return json[start..pos];
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
