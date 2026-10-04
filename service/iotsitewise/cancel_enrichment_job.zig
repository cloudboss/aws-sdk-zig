const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnrichmentJobStatus = @import("enrichment_job_status.zig").EnrichmentJobStatus;

pub const CancelEnrichmentJobInput = struct {
    /// The unique identifier of the enrichment job to cancel. This is the jobId
    /// returned by CreateEnrichmentJob.
    job_id: []const u8,

    /// The name of the IoT SiteWise workspace containing the enrichment job to
    /// cancel.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
        .workspace_name = "workspaceName",
    };
};

pub const CancelEnrichmentJobOutput = struct {
    /// The unique identifier of the cancelled enrichment job.
    job_id: []const u8,

    /// The status of the enrichment job after cancellation. This will be CANCELLED,
    /// indicating the job
    /// was successfully cancelled or was already in CANCELLED state (idempotent
    /// behavior).
    status: EnrichmentJobStatus,

    pub const json_field_names = .{
        .job_id = "jobId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelEnrichmentJobInput, options: CallOptions) !CancelEnrichmentJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelEnrichmentJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/enrichment-jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    try path_buf.appendSlice(allocator, "/cancel");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelEnrichmentJobOutput {
    const result: CancelEnrichmentJobOutput = try aws.json.parseJsonObject(
        CancelEnrichmentJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
