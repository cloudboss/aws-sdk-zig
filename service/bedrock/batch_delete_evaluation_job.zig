const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchDeleteEvaluationJobError = @import("batch_delete_evaluation_job_error.zig").BatchDeleteEvaluationJobError;
const BatchDeleteEvaluationJobItem = @import("batch_delete_evaluation_job_item.zig").BatchDeleteEvaluationJobItem;

pub const BatchDeleteEvaluationJobInput = struct {
    /// A list of one or more evaluation job Amazon Resource Names (ARNs) you want
    /// to delete.
    job_identifiers: []const []const u8,

    pub const json_field_names = .{
        .job_identifiers = "jobIdentifiers",
    };
};

pub const BatchDeleteEvaluationJobOutput = struct {
    /// A JSON object containing the HTTP status codes and the ARNs of evaluation
    /// jobs that failed to be deleted.
    errors: ?[]const BatchDeleteEvaluationJobError = null,

    /// The list of evaluation jobs for deletion.
    evaluation_jobs: ?[]const BatchDeleteEvaluationJobItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .evaluation_jobs = "evaluationJobs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteEvaluationJobInput, options: CallOptions) !BatchDeleteEvaluationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteEvaluationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/evaluation-jobs/batch-delete";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobIdentifiers\":");
    try aws.json.writeValue(@TypeOf(input.job_identifiers), input.job_identifiers, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteEvaluationJobOutput {
    const result: BatchDeleteEvaluationJobOutput = try aws.json.parseJsonObject(
        BatchDeleteEvaluationJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
