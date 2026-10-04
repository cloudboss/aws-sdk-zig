const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VerificationState = @import("verification_state.zig").VerificationState;

pub const PutVerificationStateOnViolationInput = struct {
    /// The verification state of the violation.
    verification_state: VerificationState,

    /// The description of the verification state of the violation (detect alarm).
    verification_state_description: ?[]const u8 = null,

    /// The violation ID.
    violation_id: []const u8,

    pub const json_field_names = .{
        .verification_state = "verificationState",
        .verification_state_description = "verificationStateDescription",
        .violation_id = "violationId",
    };
};

pub const PutVerificationStateOnViolationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutVerificationStateOnViolationInput, options: CallOptions) !PutVerificationStateOnViolationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutVerificationStateOnViolationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/violations/verification-state/");
    try path_buf.appendSlice(allocator, input.violation_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"verificationState\":");
    try aws.json.writeValue(@TypeOf(input.verification_state), input.verification_state, allocator, &body_buf);
    has_prev = true;
    if (input.verification_state_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"verificationStateDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutVerificationStateOnViolationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutVerificationStateOnViolationOutput = .{};

    return result;
}
