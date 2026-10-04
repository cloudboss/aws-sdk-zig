const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationOverrides = @import("configuration_overrides.zig").ConfigurationOverrides;
const JobDriver = @import("job_driver.zig").JobDriver;
const RetryPolicyConfiguration = @import("retry_policy_configuration.zig").RetryPolicyConfiguration;

pub const StartJobRunInput = struct {
    /// The client idempotency token of the job run request.
    client_token: []const u8,

    /// The configuration overrides for the job run.
    configuration_overrides: ?ConfigurationOverrides = null,

    /// The execution role ARN for the job run.
    execution_role_arn: ?[]const u8 = null,

    /// The job driver for the job run.
    job_driver: ?JobDriver = null,

    /// The job template ID to be used to start the job run.
    job_template_id: ?[]const u8 = null,

    /// The values of job template parameters to start a job run.
    job_template_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The name of the job run.
    name: ?[]const u8 = null,

    /// The Amazon EMR release version to use for the job run.
    release_label: ?[]const u8 = null,

    /// The retry policy configuration for the job run.
    retry_policy_configuration: ?RetryPolicyConfiguration = null,

    /// The tags assigned to job runs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The virtual cluster ID for which the job run request is submitted.
    virtual_cluster_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .configuration_overrides = "configurationOverrides",
        .execution_role_arn = "executionRoleArn",
        .job_driver = "jobDriver",
        .job_template_id = "jobTemplateId",
        .job_template_parameters = "jobTemplateParameters",
        .name = "name",
        .release_label = "releaseLabel",
        .retry_policy_configuration = "retryPolicyConfiguration",
        .tags = "tags",
        .virtual_cluster_id = "virtualClusterId",
    };
};

pub const StartJobRunOutput = struct {
    /// This output lists the ARN of job run.
    arn: ?[]const u8 = null,

    /// This output displays the started job run ID.
    id: ?[]const u8 = null,

    /// This output displays the name of the started job run.
    name: ?[]const u8 = null,

    /// This output displays the virtual cluster ID for which the job run was
    /// submitted.
    virtual_cluster_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .name = "name",
        .virtual_cluster_id = "virtualClusterId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartJobRunInput, options: CallOptions) !StartJobRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "emr-containers", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("emr-containers", "EMR containers", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/virtualclusters/");
    try path_buf.appendSlice(allocator, input.virtual_cluster_id);
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
    if (input.execution_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_driver) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobDriver\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_template_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobTemplateId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_template_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobTemplateParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.release_label) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"releaseLabel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.retry_policy_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retryPolicyConfiguration\":");
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
    var result: StartJobRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartJobRunOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
