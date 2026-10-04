const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetDefaultAuthorizerInput = struct {
    /// The authorizer name.
    authorizer_name: []const u8,

    pub const json_field_names = .{
        .authorizer_name = "authorizerName",
    };
};

pub const SetDefaultAuthorizerOutput = struct {
    /// The authorizer ARN.
    authorizer_arn: ?[]const u8 = null,

    /// The authorizer name.
    authorizer_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorizer_arn = "authorizerArn",
        .authorizer_name = "authorizerName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetDefaultAuthorizerInput, options: CallOptions) !SetDefaultAuthorizerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetDefaultAuthorizerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/default-authorizer";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authorizerName\":");
    try aws.json.writeValue(@TypeOf(input.authorizer_name), input.authorizer_name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetDefaultAuthorizerOutput {
    var result: SetDefaultAuthorizerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SetDefaultAuthorizerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
