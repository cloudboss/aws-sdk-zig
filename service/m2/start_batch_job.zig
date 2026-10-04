const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchJobIdentifier = @import("batch_job_identifier.zig").BatchJobIdentifier;

pub const StartBatchJobInput = struct {
    /// The unique identifier of the application associated with this batch job.
    application_id: []const u8,

    /// The Amazon Web Services Secrets Manager containing user's credentials for
    /// authentication and authorization for Start Batch Job execution operation.
    auth_secrets_manager_arn: ?[]const u8 = null,

    /// The unique identifier of the batch job.
    batch_job_identifier: BatchJobIdentifier,

    /// The collection of batch job parameters. For details about limits for keys
    /// and values,
    /// see [Coding variables in
    /// JCL](https://www.ibm.com/docs/en/workload-automation/9.3.0?topic=zos-coding-variables-in-jcl).
    job_params: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .auth_secrets_manager_arn = "authSecretsManagerArn",
        .batch_job_identifier = "batchJobIdentifier",
        .job_params = "jobParams",
    };
};

pub const StartBatchJobOutput = struct {
    /// The unique identifier of this execution of the batch job.
    execution_id: []const u8,

    pub const json_field_names = .{
        .execution_id = "executionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartBatchJobInput, options: CallOptions) !StartBatchJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartBatchJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/batch-job");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auth_secrets_manager_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authSecretsManagerArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"batchJobIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.batch_job_identifier), input.batch_job_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.job_params) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobParams\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartBatchJobOutput {
    var result: StartBatchJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartBatchJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
