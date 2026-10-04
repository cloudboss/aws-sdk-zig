const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateServiceJobInput = struct {
    /// The Batch job ID of the job to update.
    job_id: []const u8,

    /// The scheduling priority for the job. This only affects jobs in job queues
    /// with a
    /// quota-share or fair-share scheduling policy. Jobs with a higher scheduling
    /// priority are scheduled before jobs with a lower
    /// scheduling priority within a share.
    ///
    /// The minimum supported value is 0 and the maximum supported value is 9999.
    scheduling_priority: i32,

    pub const json_field_names = .{
        .job_id = "jobId",
        .scheduling_priority = "schedulingPriority",
    };
};

pub const UpdateServiceJobOutput = struct {
    /// The Amazon Resource Name (ARN) for the job.
    job_arn: ?[]const u8 = null,

    /// The unique identifier for the job.
    job_id: ?[]const u8 = null,

    /// The name of the job.
    job_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_arn = "jobArn",
        .job_id = "jobId",
        .job_name = "jobName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceJobInput, options: CallOptions) !UpdateServiceJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "batch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/updateservicejob";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobId\":");
    try aws.json.writeValue(@TypeOf(input.job_id), input.job_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"schedulingPriority\":");
    try aws.json.writeValue(@TypeOf(input.scheduling_priority), input.scheduling_priority, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceJobOutput {
    const result: UpdateServiceJobOutput = try aws.json.parseJsonObject(
        UpdateServiceJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
