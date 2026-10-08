const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateSecurityRequirementEntry = @import("update_security_requirement_entry.zig").UpdateSecurityRequirementEntry;
const BatchSecurityRequirementError = @import("batch_security_requirement_error.zig").BatchSecurityRequirementError;

pub const BatchUpdateSecurityRequirementsInput = struct {
    /// The unique identifier of the security requirement pack containing the
    /// requirements to update.
    pack_id: []const u8,

    /// The list of security requirement updates to apply.
    security_requirements: []const UpdateSecurityRequirementEntry,

    pub const json_field_names = .{
        .pack_id = "packId",
        .security_requirements = "securityRequirements",
    };
};

pub const BatchUpdateSecurityRequirementsOutput = struct {
    /// The list of errors for security requirements that failed to be updated.
    errors: ?[]const BatchSecurityRequirementError = null,

    /// The list of security requirement names that were successfully updated.
    updated_security_requirement_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .errors = "errors",
        .updated_security_requirement_names = "updatedSecurityRequirementNames",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateSecurityRequirementsInput, options: CallOptions) !BatchUpdateSecurityRequirementsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateSecurityRequirementsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/BatchUpdateSecurityRequirements";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"packId\":");
    try aws.json.writeValue(@TypeOf(input.pack_id), input.pack_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"securityRequirements\":");
    try aws.json.writeValue(@TypeOf(input.security_requirements), input.security_requirements, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateSecurityRequirementsOutput {
    const result: BatchUpdateSecurityRequirementsOutput = try aws.json.parseJsonObject(
        BatchUpdateSecurityRequirementsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
