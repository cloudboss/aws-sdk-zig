const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportErrorReportLocation = @import("export_error_report_location.zig").ExportErrorReportLocation;
const ProcessingInput = @import("processing_input.zig").ProcessingInput;
const DatasetExportJobStatus = @import("dataset_export_job_status.zig").DatasetExportJobStatus;

pub const DescribeDatasetExportJobInput = struct {
    /// The unique identifier for the dataset export job.
    job_id: []const u8,

    /// The name of the workspace that contains the dataset export job.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
        .workspace_name = "workspaceName",
    };
};

pub const DescribeDatasetExportJobOutput = struct {
    /// The timestamp when the job completed, or null if the job is still running.
    completed_at: ?i64 = null,

    /// The S3 URI where output clips are written.
    destination_s3_uri: []const u8,

    /// The location where the error report will be written on failure.
    error_report_location: ?ExportErrorReportLocation = null,

    /// The processing input that was provided in the CreateDatasetExportJob
    /// request.
    input: ?ProcessingInput = null,

    /// The unique identifier for the dataset export job.
    job_id: []const u8,

    /// The timestamp when the job started processing.
    started_at: i64,

    /// The current status of the dataset export job.
    status: DatasetExportJobStatus,

    /// The name of the workspace that contains the dataset export job.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .completed_at = "completedAt",
        .destination_s3_uri = "destinationS3Uri",
        .error_report_location = "errorReportLocation",
        .input = "input",
        .job_id = "jobId",
        .started_at = "startedAt",
        .status = "status",
        .workspace_name = "workspaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDatasetExportJobInput, options: CallOptions) !DescribeDatasetExportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDatasetExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/dataset-export-jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDatasetExportJobOutput {
    const result: DescribeDatasetExportJobOutput = try aws.json.parseJsonObject(
        DescribeDatasetExportJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
