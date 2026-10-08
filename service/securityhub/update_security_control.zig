const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParameterConfiguration = @import("parameter_configuration.zig").ParameterConfiguration;

pub const UpdateSecurityControlInput = struct {
    /// The most recent reason for updating the properties of the security control.
    /// This field accepts alphanumeric
    /// characters in addition to white spaces, dashes, and underscores.
    last_update_reason: ?[]const u8 = null,

    /// An object that specifies which security control parameters to update.
    parameters: []const aws.map.MapEntry(ParameterConfiguration),

    /// The Amazon Resource Name (ARN) or ID of the control to update.
    security_control_id: []const u8,

    pub const json_field_names = .{
        .last_update_reason = "LastUpdateReason",
        .parameters = "Parameters",
        .security_control_id = "SecurityControlId",
    };
};

pub const UpdateSecurityControlOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSecurityControlInput, options: CallOptions) !UpdateSecurityControlOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSecurityControlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/securityControl/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.last_update_reason) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LastUpdateReason\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Parameters\":");
    try aws.json.writeValue(@TypeOf(input.parameters), input.parameters, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecurityControlId\":");
    try aws.json.writeValue(@TypeOf(input.security_control_id), input.security_control_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSecurityControlOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateSecurityControlOutput = .{};

    return result;
}
