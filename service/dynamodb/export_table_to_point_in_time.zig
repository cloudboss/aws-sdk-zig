const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExportFormat = @import("export_format.zig").ExportFormat;
const ExportType = @import("export_type.zig").ExportType;
const IncrementalExportSpecification = @import("incremental_export_specification.zig").IncrementalExportSpecification;
const S3SseAlgorithm = @import("s3_sse_algorithm.zig").S3SseAlgorithm;
const ExportDescription = @import("export_description.zig").ExportDescription;

pub const ExportTableToPointInTimeInput = struct {
    /// Providing a `ClientToken` makes the call to
    /// `ExportTableToPointInTimeInput` idempotent, meaning that multiple
    /// identical calls have the same effect as one single call.
    ///
    /// A client token is valid for 8 hours after the first request that uses it is
    /// completed.
    /// After 8 hours, any request with the same client token is treated as a new
    /// request. Do
    /// not resubmit the same request with the same client token for more than 8
    /// hours, or the
    /// result might not be idempotent.
    ///
    /// If you submit a request with the same client token but a change in other
    /// parameters
    /// within the 8-hour idempotency window, DynamoDB returns an
    /// `ExportConflictException`.
    client_token: ?[]const u8 = null,

    /// The format for the exported data. Valid values for `ExportFormat` are
    /// `DYNAMODB_JSON` or `ION`.
    export_format: ?ExportFormat = null,

    /// Time in the past from which to export table data, counted in seconds from
    /// the start of
    /// the Unix epoch. The table export will be a snapshot of the table's state at
    /// this point
    /// in time.
    export_time: ?i64 = null,

    /// Choice of whether to execute as a full export or incremental export. Valid
    /// values are
    /// FULL_EXPORT or INCREMENTAL_EXPORT. The default value is FULL_EXPORT. If
    /// INCREMENTAL_EXPORT is provided, the IncrementalExportSpecification must also
    /// be
    /// used.
    export_type: ?ExportType = null,

    /// Optional object containing the parameters specific to an incremental export.
    incremental_export_specification: ?IncrementalExportSpecification = null,

    /// The name of the Amazon S3 bucket to export the snapshot to.
    s3_bucket: []const u8,

    /// The ID of the Amazon Web Services account that owns the bucket the export
    /// will be
    /// stored in.
    ///
    /// S3BucketOwner is a required parameter when exporting to a S3 bucket in
    /// another
    /// account.
    s3_bucket_owner: ?[]const u8 = null,

    /// The Amazon S3 bucket prefix to use as the file name and path of the exported
    /// snapshot.
    s3_prefix: ?[]const u8 = null,

    /// Type of encryption used on the bucket where export data will be stored.
    /// Valid values
    /// for `S3SseAlgorithm` are:
    ///
    /// * `AES256` - server-side encryption with Amazon S3 managed
    /// keys
    ///
    /// * `KMS` - server-side encryption with KMS managed
    /// keys
    s3_sse_algorithm: ?S3SseAlgorithm = null,

    /// The ID of the KMS managed key used to encrypt the S3 bucket where
    /// export data will be stored (if applicable).
    s3_sse_kms_key_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) associated with the table to export.
    table_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .export_format = "ExportFormat",
        .export_time = "ExportTime",
        .export_type = "ExportType",
        .incremental_export_specification = "IncrementalExportSpecification",
        .s3_bucket = "S3Bucket",
        .s3_bucket_owner = "S3BucketOwner",
        .s3_prefix = "S3Prefix",
        .s3_sse_algorithm = "S3SseAlgorithm",
        .s3_sse_kms_key_id = "S3SseKmsKeyId",
        .table_arn = "TableArn",
    };
};

pub const ExportTableToPointInTimeOutput = struct {
    /// Contains a description of the table export.
    export_description: ?ExportDescription = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ExportTableToPointInTimeOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .export_description = "ExportDescription",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ExportTableToPointInTimeInput, options: Options) !ExportTableToPointInTimeOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ExportTableToPointInTimeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("dynamodb", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "DynamoDB_20120810.ExportTableToPointInTime");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ExportTableToPointInTimeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ExportTableToPointInTimeOutput, body, alloc);
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
