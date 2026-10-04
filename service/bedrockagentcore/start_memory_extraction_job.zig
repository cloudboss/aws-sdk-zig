const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExtractionJob = @import("extraction_job.zig").ExtractionJob;

pub const StartMemoryExtractionJobInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotent processing of the
    /// request.
    client_token: ?[]const u8 = null,

    /// Extraction job to start in this operation.
    extraction_job: ExtractionJob,

    /// The unique identifier of the memory for which to start extraction jobs.
    memory_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .extraction_job = "extractionJob",
        .memory_id = "memoryId",
    };
};

pub const StartMemoryExtractionJobOutput = struct {
    /// Extraction Job ID that was attempted to start.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMemoryExtractionJobInput, options: CallOptions) !StartMemoryExtractionJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMemoryExtractionJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memories/");
    try path_buf.appendSlice(allocator, input.memory_id);
    try path_buf.appendSlice(allocator, "/extractionJobs/start");
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
    try body_buf.appendSlice(allocator, "\"extractionJob\":");
    try aws.json.writeValue(@TypeOf(input.extraction_job), input.extraction_job, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMemoryExtractionJobOutput {
    const result: StartMemoryExtractionJobOutput = try aws.json.parseJsonObject(
        StartMemoryExtractionJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
