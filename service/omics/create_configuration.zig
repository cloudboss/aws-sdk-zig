const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RunConfigurations = @import("run_configurations.zig").RunConfigurations;
const RunConfigurationsResponse = @import("run_configurations_response.zig").RunConfigurationsResponse;
const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;

pub const CreateConfigurationInput = struct {
    /// Optional description for the configuration.
    description: ?[]const u8 = null,

    /// User-friendly name for the configuration.
    name: []const u8,

    /// Optional request idempotency token. If not specified, a universally unique
    /// identifier (UUID) will be automatically generated for the request.
    request_id: []const u8,

    /// Required run-specific configurations.
    run_configurations: RunConfigurations,

    /// Optional tags for the configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .request_id = "requestId",
        .run_configurations = "runConfigurations",
        .tags = "tags",
    };
};

pub const CreateConfigurationOutput = struct {
    /// Unique resource identifier for the configuration.
    arn: ?[]const u8 = null,

    /// Configuration creation timestamp.
    creation_time: ?i64 = null,

    /// Description for the configuration.
    description: ?[]const u8 = null,

    /// User-friendly name for the configuration.
    name: ?[]const u8 = null,

    /// Run-specific configurations.
    run_configurations: ?RunConfigurationsResponse = null,

    /// Current configuration status.
    status: ?ConfigurationStatus = null,

    /// Tags for the configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Unique identifier for the configuration.
    uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .name = "name",
        .run_configurations = "runConfigurations",
        .status = "status",
        .tags = "tags",
        .uuid = "uuid",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfigurationInput, options: CallOptions) !CreateConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configuration";

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
    try body_buf.appendSlice(allocator, "\"requestId\":");
    try aws.json.writeValue(@TypeOf(input.request_id), input.request_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"runConfigurations\":");
    try aws.json.writeValue(@TypeOf(input.run_configurations), input.run_configurations, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfigurationOutput {
    var result: CreateConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
