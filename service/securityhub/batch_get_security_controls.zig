const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SecurityControl = @import("security_control.zig").SecurityControl;
const UnprocessedSecurityControl = @import("unprocessed_security_control.zig").UnprocessedSecurityControl;

pub const BatchGetSecurityControlsInput = struct {
    /// A list of security controls (identified with `SecurityControlId`,
    /// `SecurityControlArn`, or a mix of both parameters). The security control ID
    /// or Amazon Resource Name (ARN) is the same across standards.
    security_control_ids: []const []const u8,

    pub const json_field_names = .{
        .security_control_ids = "SecurityControlIds",
    };
};

pub const BatchGetSecurityControlsOutput = struct {
    /// An array that returns the identifier, Amazon Resource Name (ARN), and other
    /// details about a security control.
    /// The same information is returned whether the request includes
    /// `SecurityControlId` or `SecurityControlArn`.
    security_controls: ?[]const SecurityControl = null,

    /// A security control (identified with `SecurityControlId`,
    /// `SecurityControlArn`, or a mix of both parameters) for which
    /// details cannot be returned.
    unprocessed_ids: ?[]const UnprocessedSecurityControl = null,

    pub const json_field_names = .{
        .security_controls = "SecurityControls",
        .unprocessed_ids = "UnprocessedIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetSecurityControlsInput, options: CallOptions) !BatchGetSecurityControlsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetSecurityControlsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/securityControls/batchGet";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecurityControlIds\":");
    try aws.json.writeValue(@TypeOf(input.security_control_ids), input.security_control_ids, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetSecurityControlsOutput {
    var result: BatchGetSecurityControlsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetSecurityControlsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
