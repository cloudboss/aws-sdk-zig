const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportFileTaskStatus = @import("import_file_task_status.zig").ImportFileTaskStatus;

pub const GetImportFileTaskInput = struct {
    /// The ID of the import file task. This ID is returned in the response of
    /// StartImportFileTask.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetImportFileTaskOutput = struct {
    /// The time that the import task completed.
    completion_time: ?i64 = null,

    /// The import file task `id` returned in the response of StartImportFileTask.
    id: ?[]const u8 = null,

    /// The name of the import task given in StartImportFileTask.
    import_name: ?[]const u8 = null,

    /// The S3 bucket where import file is located.
    input_s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key name of the import file.
    input_s3_key: ?[]const u8 = null,

    /// The number of records that failed to be imported.
    number_of_records_failed: ?i32 = null,

    /// The number of records successfully imported.
    number_of_records_success: ?i32 = null,

    /// Start time of the import task.
    start_time: ?i64 = null,

    /// Status of import file task.
    status: ?ImportFileTaskStatus = null,

    /// The S3 bucket name for status report of import task.
    status_report_s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key name for status report of import task. The report contains
    /// details about
    /// whether each record imported successfully or why it did not.
    status_report_s3_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .id = "id",
        .import_name = "importName",
        .input_s3_bucket = "inputS3Bucket",
        .input_s3_key = "inputS3Key",
        .number_of_records_failed = "numberOfRecordsFailed",
        .number_of_records_success = "numberOfRecordsSuccess",
        .start_time = "startTime",
        .status = "status",
        .status_report_s3_bucket = "statusReportS3Bucket",
        .status_report_s3_key = "statusReportS3Key",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImportFileTaskInput, options: CallOptions) !GetImportFileTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmigrationhubstrategyrecommendation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetImportFileTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-strategy", "MigrationHubStrategy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/get-import-file-task/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetImportFileTaskOutput {
    const result: GetImportFileTaskOutput = try aws.json.parseJsonObject(
        GetImportFileTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
