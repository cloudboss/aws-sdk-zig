const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportStatus = @import("export_status.zig").ExportStatus;
const S3SseAlgorithm = @import("s3_sse_algorithm.zig").S3SseAlgorithm;

pub const GetExportInput = struct {
    /// Unique ARN identifier of the export.
    export_arn: []const u8,

    pub const json_field_names = .{
        .export_arn = "exportArn",
    };
};

pub const GetExportOutput = struct {
    /// The client token provided for this export.
    client_token: []const u8,

    /// The name of the domain that was exported.
    domain_name: []const u8,

    /// Unique ARN identifier of the export.
    export_arn: []const u8,

    /// The timestamp indicating the cutoff point for data inclusion in the export.
    /// All data inserted or modified before this time will be present in the
    /// exported data.
    /// Data insertions or modifications after this timestamp may or may not be
    /// present in the export.
    export_data_cutoff_time: ?i64 = null,

    /// The name of the manifest summary file for the export.
    export_manifest: ?[]const u8 = null,

    /// The current state of the export. Current possible values include : PENDING -
    /// export request received,
    /// IN_PROGRESS - export is being processed, SUCCEEDED - export completed
    /// successfully, and FAILED - export encountered an error.
    export_status: ExportStatus,

    /// Failure code for the result of the failed export.
    failure_code: ?[]const u8 = null,

    /// Export failure reason description.
    failure_message: ?[]const u8 = null,

    /// Total number of exported items.
    items_count: ?i64 = null,

    /// Timestamp when the export request was received by the service.
    requested_at: i64,

    /// The name of the S3 bucket for this export.
    s_3_bucket: []const u8,

    /// The S3 bucket owner account ID for this export.
    s_3_bucket_owner: ?[]const u8 = null,

    /// The S3 key prefix provided in the corresponding StartDomainExport request.
    s_3_key_prefix: ?[]const u8 = null,

    /// The S3 SSE encryption algorithm for this export.
    s_3_sse_algorithm: ?S3SseAlgorithm = null,

    /// The KMS key ID for this export.
    s_3_sse_kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .domain_name = "domainName",
        .export_arn = "exportArn",
        .export_data_cutoff_time = "exportDataCutoffTime",
        .export_manifest = "exportManifest",
        .export_status = "exportStatus",
        .failure_code = "failureCode",
        .failure_message = "failureMessage",
        .items_count = "itemsCount",
        .requested_at = "requestedAt",
        .s_3_bucket = "s3Bucket",
        .s_3_bucket_owner = "s3BucketOwner",
        .s_3_key_prefix = "s3KeyPrefix",
        .s_3_sse_algorithm = "s3SseAlgorithm",
        .s_3_sse_kms_key_id = "s3SseKmsKeyId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExportInput, options: CallOptions) !GetExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sdb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sdb", "SimpleDBv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/GetExport";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"exportArn\":");
    try aws.json.writeValue(@TypeOf(input.export_arn), input.export_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExportOutput {
    const result: GetExportOutput = try aws.json.parseJsonObject(
        GetExportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
