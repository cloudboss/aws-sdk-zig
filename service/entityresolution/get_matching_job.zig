const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ErrorDetails = @import("error_details.zig").ErrorDetails;
const JobMetrics = @import("job_metrics.zig").JobMetrics;
const JobOutputSource = @import("job_output_source.zig").JobOutputSource;
const JobStatus = @import("job_status.zig").JobStatus;

pub const GetMatchingJobInput = struct {
    /// The ID of the job.
    job_id: []const u8,

    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
        .workflow_name = "workflowName",
    };
};

pub const GetMatchingJobOutput = struct {
    /// The time at which the job has finished.
    end_time: ?i64 = null,

    /// An object containing an error message, if there was an error.
    error_details: ?ErrorDetails = null,

    /// The unique identifier of the matching job.
    job_id: []const u8,

    /// Metrics associated with the execution, specifically total records processed,
    /// unique IDs generated, and records the execution skipped.
    metrics: ?JobMetrics = null,

    /// A list of `OutputSource` objects.
    output_source_config: ?[]const JobOutputSource = null,

    /// The time at which the job was started.
    start_time: i64,

    /// The current status of the job.
    status: JobStatus,

    pub const json_field_names = .{
        .end_time = "endTime",
        .error_details = "errorDetails",
        .job_id = "jobId",
        .metrics = "metrics",
        .output_source_config = "outputSourceConfig",
        .start_time = "startTime",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMatchingJobInput, options: CallOptions) !GetMatchingJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "entityresolution", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMatchingJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/matchingworkflows/");
    try path_buf.appendSlice(allocator, input.workflow_name);
    try path_buf.appendSlice(allocator, "/jobs/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMatchingJobOutput {
    const result: GetMatchingJobOutput = try aws.json.parseJsonObject(
        GetMatchingJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
