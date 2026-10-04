const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BufferOptions = @import("buffer_options.zig").BufferOptions;
const EncryptionAtRestOptions = @import("encryption_at_rest_options.zig").EncryptionAtRestOptions;
const LogPublishingOptions = @import("log_publishing_options.zig").LogPublishingOptions;
const Pipeline = @import("pipeline.zig").Pipeline;

pub const UpdatePipelineInput = struct {
    /// Key-value pairs to configure persistent buffering for the pipeline.
    buffer_options: ?BufferOptions = null,

    /// Key-value pairs to configure encryption for data that is written to a
    /// persistent
    /// buffer.
    encryption_at_rest_options: ?EncryptionAtRestOptions = null,

    /// Key-value pairs to configure log publishing.
    log_publishing_options: ?LogPublishingOptions = null,

    /// The maximum pipeline capacity, in Ingestion Compute Units (ICUs)
    max_units: ?i32 = null,

    /// The minimum pipeline capacity, in Ingestion Compute Units (ICUs).
    min_units: ?i32 = null,

    /// The pipeline configuration in YAML format. The command accepts the pipeline
    /// configuration as
    /// a string or within a .yaml file. If you provide the configuration as a
    /// string, each new line must
    /// be escaped with `\n`.
    pipeline_configuration_body: ?[]const u8 = null,

    /// The name of the pipeline to update.
    pipeline_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that grants the pipeline
    /// permission to access
    /// Amazon Web Services resources.
    pipeline_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .buffer_options = "BufferOptions",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .log_publishing_options = "LogPublishingOptions",
        .max_units = "MaxUnits",
        .min_units = "MinUnits",
        .pipeline_configuration_body = "PipelineConfigurationBody",
        .pipeline_name = "PipelineName",
        .pipeline_role_arn = "PipelineRoleArn",
    };
};

pub const UpdatePipelineOutput = struct {
    /// Container for information about the updated pipeline.
    pipeline: ?Pipeline = null,

    pub const json_field_names = .{
        .pipeline = "Pipeline",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePipelineInput, options: CallOptions) !UpdatePipelineOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "osis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("osis", "OSIS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2022-01-01/osis/updatePipeline/");
    try path_buf.appendSlice(allocator, input.pipeline_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.buffer_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BufferOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encryption_at_rest_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncryptionAtRestOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.log_publishing_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LogPublishingOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_units) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxUnits\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.min_units) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MinUnits\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pipeline_configuration_body) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PipelineConfigurationBody\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pipeline_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PipelineRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePipelineOutput {
    const result: UpdatePipelineOutput = try aws.json.parseJsonObject(
        UpdatePipelineOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
