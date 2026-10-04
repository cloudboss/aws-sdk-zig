const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobStep = @import("job_step.zig").JobStep;

pub const ListBatchJobRestartPointsInput = struct {
    /// The unique identifier of the application.
    application_id: []const u8,

    /// The Amazon Web Services Secrets Manager containing user's credentials for
    /// authentication and authorization for List Batch Job Restart Points
    /// operation.
    auth_secrets_manager_arn: ?[]const u8 = null,

    /// The unique identifier of the batch job execution.
    execution_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .auth_secrets_manager_arn = "authSecretsManagerArn",
        .execution_id = "executionId",
    };
};

pub const ListBatchJobRestartPointsOutput = struct {
    /// Returns all the batch job steps and related information for a batch job that
    /// previously ran.
    batch_job_steps: ?[]const JobStep = null,

    pub const json_field_names = .{
        .batch_job_steps = "batchJobSteps",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBatchJobRestartPointsInput, options: CallOptions) !ListBatchJobRestartPointsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBatchJobRestartPointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/batch-job-executions/");
    try path_buf.appendSlice(allocator, input.execution_id);
    try path_buf.appendSlice(allocator, "/steps");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.auth_secrets_manager_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "authSecretsManagerArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBatchJobRestartPointsOutput {
    const result: ListBatchJobRestartPointsOutput = try aws.json.parseJsonObject(
        ListBatchJobRestartPointsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
