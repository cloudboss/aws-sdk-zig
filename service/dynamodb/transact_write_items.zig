const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const ReturnItemCollectionMetrics = @import("return_item_collection_metrics.zig").ReturnItemCollectionMetrics;
const TransactWriteItem = @import("transact_write_item.zig").TransactWriteItem;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;

/// `TransactWriteItems` is a synchronous write operation that groups up to 100
/// action requests. These actions can target items in different tables, but not
/// in
/// different Amazon Web Services accounts or Regions, and no two actions can
/// target the same
/// item. For example, you cannot both `ConditionCheck` and `Update`
/// the same item. The aggregate size of the items in the transaction cannot
/// exceed 4
/// MB.
///
/// The actions are completed atomically so that either all of them succeed, or
/// all of
/// them fail. They are defined by the following objects:
///
/// * `Put`  —   Initiates a `PutItem`
/// operation to write a new item. This structure specifies the primary key of
/// the
/// item to be written, the name of the table to write it in, an optional
/// condition
/// expression that must be satisfied for the write to succeed, a list of the
/// item's
/// attributes, and a field indicating whether to retrieve the item's attributes
/// if
/// the condition is not met.
///
/// * `Update`  —   Initiates an `UpdateItem`
/// operation to update an existing item. This structure specifies the primary
/// key
/// of the item to be updated, the name of the table where it resides, an
/// optional
/// condition expression that must be satisfied for the update to succeed, an
/// expression that defines one or more attributes to be updated, and a field
/// indicating whether to retrieve the item's attributes if the condition is not
/// met.
///
/// * `Delete`  —   Initiates a `DeleteItem`
/// operation to delete an existing item. This structure specifies the primary
/// key
/// of the item to be deleted, the name of the table where it resides, an
/// optional
/// condition expression that must be satisfied for the deletion to succeed, and
/// a
/// field indicating whether to retrieve the item's attributes if the condition
/// is
/// not met.
///
/// * `ConditionCheck`  —   Applies a condition to an item
/// that is not being modified by the transaction. This structure specifies the
/// primary key of the item to be checked, the name of the table where it
/// resides, a
/// condition expression that must be satisfied for the transaction to succeed,
/// and
/// a field indicating whether to retrieve the item's attributes if the
/// condition is
/// not met.
///
/// DynamoDB rejects the entire `TransactWriteItems` request if any of the
/// following is true:
///
/// * A condition in one of the condition expressions is not met.
///
/// * An ongoing operation is in the process of updating the same item.
///
/// * There is insufficient provisioned capacity for the transaction to be
/// completed.
///
/// * An item size becomes too large (bigger than 400 KB), a local secondary
///   index
/// (LSI) becomes too large, or a similar validation error occurs because of
/// changes
/// made by the transaction.
///
/// * The aggregate size of the items in the transaction exceeds 4 MB.
///
/// * There is a user error, such as an invalid data format.
pub const TransactWriteItemsInput = struct {
    /// Providing a `ClientRequestToken` makes the call to
    /// `TransactWriteItems` idempotent, meaning that multiple identical calls
    /// have the same effect as one single call.
    ///
    /// Although multiple identical calls using the same client request token
    /// produce the same
    /// result on the server (no side effects), the responses to the calls might not
    /// be the
    /// same. If the `ReturnConsumedCapacity` parameter is set, then the initial
    /// `TransactWriteItems` call returns the amount of write capacity units
    /// consumed in making the changes. Subsequent `TransactWriteItems` calls with
    /// the same client token return the number of read capacity units consumed in
    /// reading the
    /// item.
    ///
    /// A client request token is valid for 10 minutes after the first request that
    /// uses it is
    /// completed. After 10 minutes, any request with the same client token is
    /// treated as a new
    /// request. Do not resubmit the same request with the same client token for
    /// more than 10
    /// minutes, or the result might not be idempotent.
    ///
    /// If you submit a request with the same client token but a change in other
    /// parameters
    /// within the 10-minute idempotency window, DynamoDB returns an
    /// `IdempotentParameterMismatch` exception.
    client_request_token: ?[]const u8 = null,

    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// Determines whether item collection metrics are returned. If set to `SIZE`,
    /// the response includes statistics about item collections (if any), that were
    /// modified
    /// during the operation and are returned in the response. If set to `NONE` (the
    /// default), no statistics are returned.
    return_item_collection_metrics: ?ReturnItemCollectionMetrics = null,

    /// An ordered array of up to 100 `TransactWriteItem` objects, each of which
    /// contains a `ConditionCheck`, `Put`, `Update`, or
    /// `Delete` object. These can operate on items in different tables, but the
    /// tables must reside in the same Amazon Web Services account and Region, and
    /// no two of them
    /// can operate on the same item.
    transact_items: []const TransactWriteItem,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .return_item_collection_metrics = "ReturnItemCollectionMetrics",
        .transact_items = "TransactItems",
    };
};

pub const TransactWriteItemsOutput = struct {
    /// The capacity units consumed by the entire `TransactWriteItems` operation.
    /// The values of the list are ordered according to the ordering of the
    /// `TransactItems` request parameter.
    consumed_capacity: ?[]const ConsumedCapacity = null,

    /// A list of tables that were processed by `TransactWriteItems` and, for each
    /// table, information about any item collections that were affected by
    /// individual
    /// `UpdateItem`, `PutItem`, or `DeleteItem`
    /// operations.
    item_collection_metrics: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const TransactWriteItemsOutput) void {
        if (self.item_collection_metrics) |v| {
            self.allocator.free(v);
        }
    }

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .item_collection_metrics = "ItemCollectionMetrics",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: TransactWriteItemsInput, options: Options) !TransactWriteItemsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: TransactWriteItemsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("dynamodb", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ClientRequestToken\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.return_consumed_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ReturnConsumedCapacity\":\"");
        try body_buf.appendSlice(alloc, @tagName(v));
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.return_item_collection_metrics) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ReturnItemCollectionMetrics\":\"");
        try body_buf.appendSlice(alloc, @tagName(v));
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "DynamoDB_20120810.TransactWriteItems");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !TransactWriteItemsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{ .allocator = alloc };
    return aws.json.parseJsonObject(TransactWriteItemsOutput, body, alloc);
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

fn appendJsonEscaped(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            0x22 => { try buf.append(alloc, 0x5C); try buf.append(alloc, 0x22); },
            0x5C => { try buf.append(alloc, 0x5C); try buf.append(alloc, 0x5C); },
            0x0A => { try buf.append(alloc, 0x5C); try buf.append(alloc, 'n'); },
            0x0D => { try buf.append(alloc, 0x5C); try buf.append(alloc, 'r'); },
            0x09 => { try buf.append(alloc, 0x5C); try buf.append(alloc, 't'); },
            else => {
                if (c < 0x20) {
                    const hex = "0123456789abcdef";
                    try buf.append(alloc, 0x5C); // backslash
                    try buf.append(alloc, 'u');
                    try buf.append(alloc, '0');
                    try buf.append(alloc, '0');
                    try buf.append(alloc, hex[c >> 4]);
                    try buf.append(alloc, hex[c & 0x0F]);
                } else {
                    try buf.append(alloc, c);
                }
            }
        }
    }
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
