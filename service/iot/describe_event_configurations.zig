const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Configuration = @import("configuration.zig").Configuration;

pub const DescribeEventConfigurationsInput = struct {
};

pub const DescribeEventConfigurationsOutput = struct {
    /// The creation date of the event configuration.
    creation_date: ?i64 = null,

    /// The event configurations.
    event_configurations: ?[]const aws.map.MapEntry(Configuration) = null,

    /// The date the event configurations were last modified.
    last_modified_date: ?i64 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .event_configurations = "eventConfigurations",
        .last_modified_date = "lastModifiedDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventConfigurationsInput, options: CallOptions) !DescribeEventConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEventConfigurationsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/event-configurations";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEventConfigurationsOutput {
    const result: DescribeEventConfigurationsOutput = try aws.json.parseJsonObject(
        DescribeEventConfigurationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
