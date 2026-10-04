const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExpressionType = @import("expression_type.zig").ExpressionType;

pub const GetDestinationInput = struct {
    /// The name of the resource to get.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const GetDestinationOutput = struct {
    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8 = null,

    /// The description of the resource.
    description: ?[]const u8 = null,

    /// The rule name or topic rule to send messages to.
    expression: ?[]const u8 = null,

    /// The type of value in `Expression`.
    expression_type: ?ExpressionType = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    /// The ARN of the IAM Role that authorizes the destination.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .expression = "Expression",
        .expression_type = "ExpressionType",
        .name = "Name",
        .role_arn = "RoleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDestinationInput, options: CallOptions) !GetDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/destinations/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDestinationOutput {
    var result: GetDestinationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDestinationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
