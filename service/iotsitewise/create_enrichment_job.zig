const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnrichmentJobConfiguration = @import("enrichment_job_configuration.zig").EnrichmentJobConfiguration;
const EnrichmentJobStatus = @import("enrichment_job_status.zig").EnrichmentJobStatus;

pub const CreateEnrichmentJobInput = struct {
    /// Optional unique token that makes the operation idempotent. If you submit the
    /// same request with the
    /// same token within the idempotency window, the service returns the original
    /// job without creating a
    /// duplicate. Use a UUID or timestamp-based token for each unique request.
    client_token: ?[]const u8 = null,

    /// Configuration defining the type of enrichment analysis to perform and which
    /// video data to analyze.
    /// Currently supports eventDetection for generating embeddings from video data
    /// for semantic search.
    job_configuration: EnrichmentJobConfiguration,

    /// The name of the IoT SiteWise workspace containing the video data to analyze.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .job_configuration = "jobConfiguration",
        .workspace_name = "workspaceName",
    };
};

pub const CreateEnrichmentJobOutput = struct {
    /// Timestamp when the enrichment job was created in ISO 8601 format.
    created_at: i64,

    /// Unique identifier for the enrichment job. Use this ID with
    /// DescribeEnrichmentJob to monitor
    /// progress or with CancelEnrichmentJob to cancel the job.
    job_id: []const u8,

    /// Initial status of the enrichment job, typically PENDING. The job will
    /// transition to RUNNING when
    /// processing begins, then to a terminal state (COMPLETED, FAILED, TIMED_OUT,
    /// or CANCELLED).
    /// Use DescribeEnrichmentJob to track status changes.
    status: EnrichmentJobStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .job_id = "jobId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnrichmentJobInput, options: CallOptions) !CreateEnrichmentJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnrichmentJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/enrichment-jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.job_configuration), input.job_configuration, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnrichmentJobOutput {
    const result: CreateEnrichmentJobOutput = try aws.json.parseJsonObject(
        CreateEnrichmentJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
