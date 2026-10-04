const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeConfigurationRevisionInput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies an MSK configuration
    /// and all of its revisions.
    arn: []const u8,

    /// A string that uniquely identifies a revision of an MSK configuration.
    revision: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .revision = "Revision",
    };
};

pub const DescribeConfigurationRevisionOutput = struct {
    /// The Amazon Resource Name (ARN) of the configuration.
    arn: ?[]const u8 = null,

    /// The time when the configuration was created.
    creation_time: ?i64 = null,

    /// The description of the configuration.
    description: ?[]const u8 = null,

    /// The revision number.
    revision: ?i64 = null,

    /// Contents of the server.properties file. When using the API, you must ensure
    /// that the contents of the file are base64 encoded.
    /// When using the AWS Management Console, the SDK, or the AWS CLI, the contents
    /// of server.properties can be in plaintext.
    server_properties: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .description = "Description",
        .revision = "Revision",
        .server_properties = "ServerProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConfigurationRevisionInput, options: CallOptions) !DescribeConfigurationRevisionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConfigurationRevisionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/configurations/");
    try path_buf.appendSlice(allocator, input.arn);
    try path_buf.appendSlice(allocator, "/revisions/");
    try path_buf.appendSlice(allocator, input.revision);
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
    var result: DescribeConfigurationRevisionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeConfigurationRevisionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
