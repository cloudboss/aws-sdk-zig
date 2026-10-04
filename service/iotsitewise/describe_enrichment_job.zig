const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnrichmentJobConfiguration = @import("enrichment_job_configuration.zig").EnrichmentJobConfiguration;
const JobType = @import("job_type.zig").JobType;
const EnrichmentJobStatus = @import("enrichment_job_status.zig").EnrichmentJobStatus;

pub const DescribeEnrichmentJobInput = struct {
    /// The unique identifier of the enrichment job to retrieve. This is the jobId
    /// returned by CreateEnrichmentJob.
    job_id: []const u8,

    /// The name of the IoT SiteWise workspace containing the enrichment job.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
        .workspace_name = "workspaceName",
    };
};

pub const DescribeEnrichmentJobOutput = struct {
    /// Timestamp when the job was cancelled in ISO 8601 format. Only present if
    /// status is CANCELLED.
    cancelled_at: ?i64 = null,

    /// Timestamp when the job completed successfully in ISO 8601 format. Only
    /// present if status is COMPLETED.
    completed_at: ?i64 = null,

    /// Timestamp when the enrichment job was created in ISO 8601 format.
    created_at: i64,

    /// Human-readable error message explaining why the job failed. Only present if
    /// status is FAILED.
    /// Use this information to diagnose configuration issues, permission problems,
    /// or data processing errors.
    failure_message: ?[]const u8 = null,

    /// The complete job configuration as originally submitted, including the
    /// analysis type and parameters.
    /// For event detection jobs, this includes the dataset ID, time series
    /// identifier, and trim settings
    /// defining the analysis time range.
    job_configuration: ?EnrichmentJobConfiguration = null,

    /// The unique identifier of the enrichment job.
    job_id: []const u8,

    /// The type of enrichment job, derived from the job configuration. Currently
    /// EVENT_DETECTION is the only supported type.
    job_type: JobType,

    /// Current status of the enrichment job. Possible values:
    ///
    /// * PENDING: Job is waiting to start processing
    ///
    /// * RUNNING: Job is actively processing video data
    ///
    /// * COMPLETED: Job finished successfully; embeddings available in IoT SiteWise
    ///
    /// * FAILED: Job encountered an error; see failureMessage for details
    ///
    /// * TIMED_OUT: Job exceeded maximum processing time limit
    ///
    /// * CANCELLED: Job was cancelled by user request
    status: EnrichmentJobStatus,

    /// Timestamp when the job status was last updated in ISO 8601 format. Useful
    /// for tracking recent activity.
    updated_at: ?i64 = null,

    /// The name of the IoT SiteWise workspace containing the job.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .cancelled_at = "cancelledAt",
        .completed_at = "completedAt",
        .created_at = "createdAt",
        .failure_message = "failureMessage",
        .job_configuration = "jobConfiguration",
        .job_id = "jobId",
        .job_type = "jobType",
        .status = "status",
        .updated_at = "updatedAt",
        .workspace_name = "workspaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEnrichmentJobInput, options: CallOptions) !DescribeEnrichmentJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEnrichmentJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/enrichment-jobs/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEnrichmentJobOutput {
    const result: DescribeEnrichmentJobOutput = try aws.json.parseJsonObject(
        DescribeEnrichmentJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
