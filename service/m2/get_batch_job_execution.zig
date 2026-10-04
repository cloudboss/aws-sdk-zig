const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchJobIdentifier = @import("batch_job_identifier.zig").BatchJobIdentifier;
const JobStepRestartMarker = @import("job_step_restart_marker.zig").JobStepRestartMarker;
const BatchJobType = @import("batch_job_type.zig").BatchJobType;
const BatchJobExecutionStatus = @import("batch_job_execution_status.zig").BatchJobExecutionStatus;

pub const GetBatchJobExecutionInput = struct {
    /// The identifier of the application.
    application_id: []const u8,

    /// The unique identifier of the batch job execution.
    execution_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .execution_id = "executionId",
    };
};

pub const GetBatchJobExecutionOutput = struct {
    /// The identifier of the application.
    application_id: []const u8,

    /// The unique identifier of this batch job.
    batch_job_identifier: ?BatchJobIdentifier = null,

    /// The timestamp when the batch job execution ended.
    end_time: ?i64 = null,

    /// The unique identifier for this batch job execution.
    execution_id: []const u8,

    /// The unique identifier for this batch job.
    job_id: ?[]const u8 = null,

    /// The name of this batch job.
    job_name: ?[]const u8 = null,

    /// The step/procedure step information for the restart batch job operation.
    job_step_restart_marker: ?JobStepRestartMarker = null,

    /// The type of job.
    job_type: ?BatchJobType = null,

    /// The user for the job.
    job_user: ?[]const u8 = null,

    /// The batch job return code from either the Blu Age or Micro Focus runtime
    /// engines. For more
    /// information, see [Batch return
    /// codes](https://www.ibm.com/docs/en/was/8.5.5?topic=model-batch-return-codes)
    /// in the *IBM WebSphere Application Server*
    /// documentation.
    return_code: ?[]const u8 = null,

    /// The timestamp when the batch job execution started.
    start_time: i64,

    /// The status of the batch job execution.
    status: BatchJobExecutionStatus,

    /// The reason for the reported status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .batch_job_identifier = "batchJobIdentifier",
        .end_time = "endTime",
        .execution_id = "executionId",
        .job_id = "jobId",
        .job_name = "jobName",
        .job_step_restart_marker = "jobStepRestartMarker",
        .job_type = "jobType",
        .job_user = "jobUser",
        .return_code = "returnCode",
        .start_time = "startTime",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBatchJobExecutionInput, options: CallOptions) !GetBatchJobExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "m2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBatchJobExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/batch-job-executions/");
    try path_buf.appendSlice(allocator, input.execution_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBatchJobExecutionOutput {
    const result: GetBatchJobExecutionOutput = try aws.json.parseJsonObject(
        GetBatchJobExecutionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
