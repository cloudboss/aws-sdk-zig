const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchSecurityRequirementError = @import("batch_security_requirement_error.zig").BatchSecurityRequirementError;
const BatchGetSecurityRequirementResult = @import("batch_get_security_requirement_result.zig").BatchGetSecurityRequirementResult;

pub const BatchGetSecurityRequirementsInput = struct {
    /// The unique identifier of the security requirement pack to retrieve
    /// requirements from.
    pack_id: []const u8,

    /// The list of security requirement names to retrieve.
    security_requirement_names: []const []const u8,

    pub const json_field_names = .{
        .pack_id = "packId",
        .security_requirement_names = "securityRequirementNames",
    };
};

pub const BatchGetSecurityRequirementsOutput = struct {
    /// The list of errors for security requirements that failed to be retrieved.
    errors: ?[]const BatchSecurityRequirementError = null,

    /// The list of security requirements that were successfully retrieved.
    security_requirements: ?[]const BatchGetSecurityRequirementResult = null,

    pub const json_field_names = .{
        .errors = "errors",
        .security_requirements = "securityRequirements",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetSecurityRequirementsInput, options: CallOptions) !BatchGetSecurityRequirementsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetSecurityRequirementsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/BatchGetSecurityRequirements";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"packId\":");
    try aws.json.writeValue(@TypeOf(input.pack_id), input.pack_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"securityRequirementNames\":");
    try aws.json.writeValue(@TypeOf(input.security_requirement_names), input.security_requirement_names, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetSecurityRequirementsOutput {
    const result: BatchGetSecurityRequirementsOutput = try aws.json.parseJsonObject(
        BatchGetSecurityRequirementsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
