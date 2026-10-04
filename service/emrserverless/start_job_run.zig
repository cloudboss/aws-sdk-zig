const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationOverrides = @import("configuration_overrides.zig").ConfigurationOverrides;
const JobRunExecutionIamPolicy = @import("job_run_execution_iam_policy.zig").JobRunExecutionIamPolicy;
const JobDriver = @import("job_driver.zig").JobDriver;
const JobRunMode = @import("job_run_mode.zig").JobRunMode;
const RetryPolicy = @import("retry_policy.zig").RetryPolicy;

pub const StartJobRunInput = struct {
    /// The ID of the application on which to run the job.
    application_id: []const u8,

    /// The client idempotency token of the job run to start. Its value must be
    /// unique for each request.
    client_token: []const u8,

    /// The configuration overrides for the job run.
    configuration_overrides: ?ConfigurationOverrides = null,

    /// You can pass an optional IAM policy. The resulting job IAM role permissions
    /// will be an intersection of this policy and the policy associated with your
    /// job execution role.
    execution_iam_policy: ?JobRunExecutionIamPolicy = null,

    /// The execution role ARN for the job run.
    execution_role_arn: []const u8,

    /// The maximum duration for the job run to run. If the job run runs beyond this
    /// duration, it will be automatically cancelled.
    execution_timeout_minutes: ?i64 = null,

    /// The job driver for the job run.
    job_driver: ?JobDriver = null,

    /// The mode of the job run when it starts.
    mode: ?JobRunMode = null,

    /// The optional job run name. This doesn't have to be unique.
    name: ?[]const u8 = null,

    /// The retry policy when job run starts.
    retry_policy: ?RetryPolicy = null,

    /// The tags assigned to the job run.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .client_token = "clientToken",
        .configuration_overrides = "configurationOverrides",
        .execution_iam_policy = "executionIamPolicy",
        .execution_role_arn = "executionRoleArn",
        .execution_timeout_minutes = "executionTimeoutMinutes",
        .job_driver = "jobDriver",
        .mode = "mode",
        .name = "name",
        .retry_policy = "retryPolicy",
        .tags = "tags",
    };
};

pub const StartJobRunOutput = struct {
    /// This output displays the application ID on which the job run was submitted.
    application_id: []const u8,

    /// This output displays the ARN of the job run..
    arn: []const u8,

    /// The output contains the ID of the started job run.
    job_run_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .arn = "arn",
        .job_run_id = "jobRunId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartJobRunInput, options: CallOptions) !StartJobRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "emr-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartJobRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr-serverless", "EMR Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/jobruns");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.configuration_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configurationOverrides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_iam_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionIamPolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"executionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.execution_role_arn), input.execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.execution_timeout_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionTimeoutMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_driver) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobDriver\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.retry_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retryPolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartJobRunOutput {
    const result: StartJobRunOutput = try aws.json.parseJsonObject(
        StartJobRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
