const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkerConfigurationRevisionSummary = @import("worker_configuration_revision_summary.zig").WorkerConfigurationRevisionSummary;
const WorkerConfigurationState = @import("worker_configuration_state.zig").WorkerConfigurationState;

pub const CreateWorkerConfigurationInput = struct {
    /// A summary description of the worker configuration.
    description: ?[]const u8 = null,

    /// The name of the worker configuration.
    name: []const u8,

    /// Base64 encoded contents of connect-distributed.properties file.
    properties_file_content: []const u8,

    /// The tags you want to attach to the worker configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .properties_file_content = "propertiesFileContent",
        .tags = "tags",
    };
};

pub const CreateWorkerConfigurationOutput = struct {
    /// The time that the worker configuration was created.
    creation_time: ?i64 = null,

    /// The latest revision of the worker configuration.
    latest_revision: ?WorkerConfigurationRevisionSummary = null,

    /// The name of the worker configuration.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that Amazon assigned to the worker
    /// configuration.
    worker_configuration_arn: ?[]const u8 = null,

    /// The state of the worker configuration.
    worker_configuration_state: ?WorkerConfigurationState = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .latest_revision = "latestRevision",
        .name = "name",
        .worker_configuration_arn = "workerConfigurationArn",
        .worker_configuration_state = "workerConfigurationState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkerConfigurationInput, options: CallOptions) !CreateWorkerConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafkaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkerConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/worker-configurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"propertiesFileContent\":");
    try aws.json.writeValue(@TypeOf(input.properties_file_content), input.properties_file_content, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkerConfigurationOutput {
    const result: CreateWorkerConfigurationOutput = try aws.json.parseJsonObject(
        CreateWorkerConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
