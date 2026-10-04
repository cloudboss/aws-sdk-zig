const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RegisterConnectorV2Input = struct {
    /// The authCode retrieved from authUrl to complete the OAuth 2.0 authorization
    /// code flow.
    auth_code: []const u8,

    /// The authState retrieved from authUrl to complete the OAuth 2.0 authorization
    /// code flow.
    auth_state: []const u8,

    pub const json_field_names = .{
        .auth_code = "AuthCode",
        .auth_state = "AuthState",
    };
};

pub const RegisterConnectorV2Output = struct {
    /// The Amazon Resource Name (ARN) of the connectorV2.
    connector_arn: ?[]const u8 = null,

    /// The UUID of the connectorV2 to identify connectorV2 resource.
    connector_id: []const u8,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
        .connector_id = "ConnectorId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterConnectorV2Input, options: CallOptions) !RegisterConnectorV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterConnectorV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/connectorsv2/register";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AuthCode\":");
    try aws.json.writeValue(@TypeOf(input.auth_code), input.auth_code, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AuthState\":");
    try aws.json.writeValue(@TypeOf(input.auth_state), input.auth_state, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterConnectorV2Output {
    var result: RegisterConnectorV2Output = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterConnectorV2Output, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
