const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeConfigurationRevisionInput = struct {
    /// The unique ID that Amazon MQ generates for the configuration.
    configuration_id: []const u8,

    /// The revision of the configuration.
    configuration_revision: []const u8,

    pub const json_field_names = .{
        .configuration_id = "ConfigurationId",
        .configuration_revision = "ConfigurationRevision",
    };
};

pub const DescribeConfigurationRevisionOutput = struct {
    /// Required. The unique ID that Amazon MQ generates for the configuration.
    configuration_id: ?[]const u8 = null,

    /// Required. The date and time of the configuration.
    created: ?i64 = null,

    /// Amazon MQ for ActiveMQ: the base64-encoded XML configuration. Amazon MQ for
    /// RabbitMQ: base64-encoded Cuttlefish.
    data: ?[]const u8 = null,

    /// The description of the configuration.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_id = "ConfigurationId",
        .created = "Created",
        .data = "Data",
        .description = "Description",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConfigurationRevisionInput, options: CallOptions) !DescribeConfigurationRevisionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConfigurationRevisionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mq", "mq", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/configurations/");
    try path_buf.appendSlice(allocator, input.configuration_id);
    try path_buf.appendSlice(allocator, "/revisions/");
    try path_buf.appendSlice(allocator, input.configuration_revision);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConfigurationRevisionOutput {
    const result: DescribeConfigurationRevisionOutput = try aws.json.parseJsonObject(
        DescribeConfigurationRevisionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
