const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchStopJobRunError = @import("batch_stop_job_run_error.zig").BatchStopJobRunError;
const BatchStopJobRunSuccessfulSubmission = @import("batch_stop_job_run_successful_submission.zig").BatchStopJobRunSuccessfulSubmission;

pub const BatchStopJobRunInput = struct {
    /// The name of the job definition for which to stop job runs.
    job_name: []const u8,

    /// A list of the `JobRunIds` that should be stopped for that job
    /// definition.
    job_run_ids: []const []const u8,

    pub const json_field_names = .{
        .job_name = "JobName",
        .job_run_ids = "JobRunIds",
    };
};

pub const BatchStopJobRunOutput = struct {
    /// A list of the errors that were encountered in trying to stop `JobRuns`,
    /// including the `JobRunId` for which each error was encountered and details
    /// about the
    /// error.
    errors: ?[]const BatchStopJobRunError = null,

    /// A list of the JobRuns that were successfully submitted for stopping.
    successful_submissions: ?[]const BatchStopJobRunSuccessfulSubmission = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .successful_submissions = "SuccessfulSubmissions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchStopJobRunInput, options: CallOptions) !BatchStopJobRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchStopJobRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.BatchStopJobRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchStopJobRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchStopJobRunOutput, body, allocator);
}
