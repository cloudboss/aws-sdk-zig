const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportFormat = @import("export_format.zig").ExportFormat;
const ExportType = @import("export_type.zig").ExportType;
const FilterSpecification = @import("filter_specification.zig").FilterSpecification;
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

    /// The criteria used to filter which items are included in the point-in-time
    /// export.
    /// When you specify this parameter, only items that match the key conditions
    /// and filter
    /// expressions are exported.
    filter_specification: ?FilterSpecification = null,

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
        .filter_specification = "FilterSpecification",
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

    pub const json_field_names = .{
        .export_description = "ExportDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportTableToPointInTimeInput, options: CallOptions) !ExportTableToPointInTimeOutput {
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ExportTableToPointInTimeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.ExportTableToPointInTime");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportTableToPointInTimeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ExportTableToPointInTimeOutput, body, allocator);
}
