const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OtaMechanism = @import("ota_mechanism.zig").OtaMechanism;
const OtaTaskSchedulingConfig = @import("ota_task_scheduling_config.zig").OtaTaskSchedulingConfig;
const OtaTaskExecutionRetryConfig = @import("ota_task_execution_retry_config.zig").OtaTaskExecutionRetryConfig;
const OtaType = @import("ota_type.zig").OtaType;
const OtaProtocol = @import("ota_protocol.zig").OtaProtocol;

pub const CreateOtaTaskInput = struct {
    /// An idempotency token. If you retry a request that completed successfully
    /// initially using the same client token and parameters, then the retry attempt
    /// will succeed without performing any further actions.
    client_token: ?[]const u8 = null,

    /// The description of the over-the-air (OTA) task.
    description: ?[]const u8 = null,

    /// The deployment mechanism for the over-the-air (OTA) task.
    ota_mechanism: ?OtaMechanism = null,

    ota_scheduling_config: ?OtaTaskSchedulingConfig = null,

    /// The query string to add things to the thing group.
    ota_target_query_string: ?[]const u8 = null,

    ota_task_execution_retry_config: ?OtaTaskExecutionRetryConfig = null,

    /// The frequency type for the over-the-air (OTA) task.
    ota_type: OtaType,

    /// The connection protocol the over-the-air (OTA) task uses to update the
    /// device.
    protocol: ?OtaProtocol = null,

    /// The URL to the Amazon S3 bucket where the over-the-air (OTA) task is stored.
    s3_url: []const u8,

    /// A set of key/value pairs that are used to manage the over-the-air (OTA)
    /// task.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The device targeted for the over-the-air (OTA) task.
    target: ?[]const []const u8 = null,

    /// The identifier for the over-the-air (OTA) task configuration.
    task_configuration_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .ota_mechanism = "OtaMechanism",
        .ota_scheduling_config = "OtaSchedulingConfig",
        .ota_target_query_string = "OtaTargetQueryString",
        .ota_task_execution_retry_config = "OtaTaskExecutionRetryConfig",
        .ota_type = "OtaType",
        .protocol = "Protocol",
        .s3_url = "S3Url",
        .tags = "Tags",
        .target = "Target",
        .task_configuration_id = "TaskConfigurationId",
    };
};

pub const CreateOtaTaskOutput = struct {
    /// A description of the over-the-air (OTA) task.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the over-the-air (OTA) task.
    task_arn: ?[]const u8 = null,

    /// The identifier of the over-the-air (OTA) task.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .task_arn = "TaskArn",
        .task_id = "TaskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOtaTaskInput, options: CallOptions) !CreateOtaTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOtaTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ota-tasks";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ota_mechanism) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OtaMechanism\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ota_scheduling_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OtaSchedulingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ota_target_query_string) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OtaTargetQueryString\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ota_task_execution_retry_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OtaTaskExecutionRetryConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OtaType\":");
    try aws.json.writeValue(@TypeOf(input.ota_type), input.ota_type, allocator, &body_buf);
    has_prev = true;
    if (input.protocol) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Protocol\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"S3Url\":");
    try aws.json.writeValue(@TypeOf(input.s3_url), input.s3_url, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Target\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.task_configuration_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TaskConfigurationId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOtaTaskOutput {
    const result: CreateOtaTaskOutput = try aws.json.parseJsonObject(
        CreateOtaTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
