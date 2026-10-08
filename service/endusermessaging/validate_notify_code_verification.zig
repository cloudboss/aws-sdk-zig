const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VerificationStatus = @import("verification_status.zig").VerificationStatus;

pub const ValidateNotifyCodeVerificationInput = struct {
    /// The one-time passcode that the recipient submitted for validation.
    code: []const u8,

    /// The recipient identifier. For the TEXT and VOICE channels, specify an E.164
    /// phone number. For the WhatsApp channel, specify a WhatsApp address.
    destination_identity: []const u8,

    /// The caller-supplied reference identifier used to locate the verification.
    /// This value must match the value that you supplied to the
    /// SendNotifyCodeVerification operation.
    reference_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .destination_identity = "destinationIdentity",
        .reference_id = "referenceId",
    };
};

pub const ValidateNotifyCodeVerificationOutput = struct {
    /// The outcome of the validation attempt. VALID indicates that the submitted
    /// passcode matched an active verification. INVALID indicates that the passcode
    /// did not match, expired, or exceeded its attempt limit.
    status: VerificationStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidateNotifyCodeVerificationInput, options: CallOptions) !ValidateNotifyCodeVerificationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "end-user-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidateNotifyCodeVerificationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/notify-code-verifications/validate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"code\":");
    try aws.json.writeValue(@TypeOf(input.code), input.code, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationIdentity\":");
    try aws.json.writeValue(@TypeOf(input.destination_identity), input.destination_identity, allocator, &body_buf);
    has_prev = true;
    if (input.reference_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"referenceId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidateNotifyCodeVerificationOutput {
    const result: ValidateNotifyCodeVerificationOutput = try aws.json.parseJsonObject(
        ValidateNotifyCodeVerificationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
