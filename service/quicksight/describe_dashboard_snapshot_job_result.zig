const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotJobErrorInfo = @import("snapshot_job_error_info.zig").SnapshotJobErrorInfo;
const SnapshotJobStatus = @import("snapshot_job_status.zig").SnapshotJobStatus;
const SnapshotJobResult = @import("snapshot_job_result.zig").SnapshotJobResult;

pub const DescribeDashboardSnapshotJobResultInput = struct {
    /// The ID of the Amazon Web Services account that the dashboard snapshot job is
    /// executed in.
    aws_account_id: []const u8,

    /// The ID of the dashboard that you have started a snapshot job for.
    dashboard_id: []const u8,

    /// The ID of the job to be described. The job ID is set when you start a new
    /// job with a `StartDashboardSnapshotJob` API call.
    snapshot_job_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .dashboard_id = "DashboardId",
        .snapshot_job_id = "SnapshotJobId",
    };
};

pub const DescribeDashboardSnapshotJobResultOutput = struct {
    /// The Amazon Resource Name (ARN) for the snapshot job. The job ARN is
    /// generated when you start a new job with a `StartDashboardSnapshotJob` API
    /// call.
    arn: ?[]const u8 = null,

    /// The time that a snapshot job was created.
    created_time: ?i64 = null,

    /// Displays information for the error that caused a job to fail.
    error_info: ?SnapshotJobErrorInfo = null,

    /// Indicates the status of a job after it has reached a terminal state. A
    /// finished snapshot job will retuen a `COMPLETED` or `FAILED` status.
    job_status: ?SnapshotJobStatus = null,

    /// The time that a snapshot job status was last updated.
    last_updated_time: ?i64 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The result of the snapshot job. Jobs that have successfully completed will
    /// return the S3Uri where they are located. Jobs that have failedwill return
    /// information on the error that caused the job to fail.
    result: ?SnapshotJobResult = null,

    /// The HTTP status of the request
    status: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .error_info = "ErrorInfo",
        .job_status = "JobStatus",
        .last_updated_time = "LastUpdatedTime",
        .request_id = "RequestId",
        .result = "Result",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDashboardSnapshotJobResultInput, options: CallOptions) !DescribeDashboardSnapshotJobResultOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDashboardSnapshotJobResultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/dashboards/");
    try path_buf.appendSlice(allocator, input.dashboard_id);
    try path_buf.appendSlice(allocator, "/snapshot-jobs/");
    try path_buf.appendSlice(allocator, input.snapshot_job_id);
    try path_buf.appendSlice(allocator, "/result");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDashboardSnapshotJobResultOutput {
    var result: DescribeDashboardSnapshotJobResultOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDashboardSnapshotJobResultOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
