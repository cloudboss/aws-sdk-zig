const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationRevision = @import("configuration_revision.zig").ConfigurationRevision;
const SanitizationWarning = @import("sanitization_warning.zig").SanitizationWarning;

pub const UpdateConfigurationInput = struct {
    /// The unique ID that Amazon MQ generates for the configuration.
    configuration_id: []const u8,

    /// Amazon MQ for Active MQ: The base64-encoded XML configuration. Amazon MQ for
    /// RabbitMQ: the base64-encoded Cuttlefish configuration.
    data: []const u8,

    /// The description of the configuration.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_id = "ConfigurationId",
        .data = "Data",
        .description = "Description",
    };
};

pub const UpdateConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the configuration.
    arn: ?[]const u8 = null,

    /// Required. The date and time of the configuration.
    created: ?i64 = null,

    /// The unique ID that Amazon MQ generates for the configuration.
    id: ?[]const u8 = null,

    /// The latest revision of the configuration.
    latest_revision: ?ConfigurationRevision = null,

    /// The name of the configuration. This value can contain only alphanumeric
    /// characters, dashes, periods, underscores, and tildes (- . _ ~). This value
    /// must be 1-150 characters long.
    name: ?[]const u8 = null,

    /// The list of the first 20 warnings about the configuration elements or
    /// attributes that were sanitized.
    warnings: ?[]const SanitizationWarning = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created = "Created",
        .id = "Id",
        .latest_revision = "LatestRevision",
        .name = "Name",
        .warnings = "Warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConfigurationInput, options: CallOptions) !UpdateConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mq", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mq", "mq", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/configurations/");
    try path_buf.appendSlice(allocator, input.configuration_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Data\":");
    try aws.json.writeValue(@TypeOf(input.data), input.data, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConfigurationOutput {
    const result: UpdateConfigurationOutput = try aws.json.parseJsonObject(
        UpdateConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
