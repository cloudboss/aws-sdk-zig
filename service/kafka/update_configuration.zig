const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationRevision = @import("configuration_revision.zig").ConfigurationRevision;

pub const UpdateConfigurationInput = struct {
    /// The Amazon Resource Name (ARN) of the configuration.
    arn: []const u8,

    /// The description of the configuration revision.
    description: ?[]const u8 = null,

    /// Contents of the server.properties file. When using the API, you must ensure
    /// that the contents of the file are base64 encoded.
    /// When using the AWS Management Console, the SDK, or the AWS CLI, the contents
    /// of server.properties can be in plaintext.
    server_properties: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .server_properties = "ServerProperties",
    };
};

pub const UpdateConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the configuration.
    arn: ?[]const u8 = null,

    /// Latest revision of the configuration.
    latest_revision: ?ConfigurationRevision = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .latest_revision = "LatestRevision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConfigurationInput, options: CallOptions) !UpdateConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafka", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/configurations/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ServerProperties\":");
    try aws.json.writeValue(@TypeOf(input.server_properties), input.server_properties, allocator, &body_buf);
    has_prev = true;

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
    var result: UpdateConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
