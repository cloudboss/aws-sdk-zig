const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutEmailIdentityFeedbackAttributesInput = struct {
    /// Sets the feedback forwarding configuration for the identity.
    ///
    /// If the value is `true`, you receive email notifications when bounce or
    /// complaint events occur. These notifications are sent to the address that you
    /// specified
    /// in the `Return-Path` header of the original email.
    ///
    /// You're required to have a method of tracking bounces and complaints. If you
    /// haven't
    /// set up another mechanism for receiving bounce or complaint notifications
    /// (for example,
    /// by setting up an event destination), you receive an email notification when
    /// these events
    /// occur (even if this setting is disabled).
    email_forwarding_enabled: ?bool = null,

    /// The email identity.
    email_identity: []const u8,

    pub const json_field_names = .{
        .email_forwarding_enabled = "EmailForwardingEnabled",
        .email_identity = "EmailIdentity",
    };
};

pub const PutEmailIdentityFeedbackAttributesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutEmailIdentityFeedbackAttributesInput, options: CallOptions) !PutEmailIdentityFeedbackAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutEmailIdentityFeedbackAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/identities/");
    try path_buf.appendSlice(allocator, input.email_identity);
    try path_buf.appendSlice(allocator, "/feedback");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.email_forwarding_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EmailForwardingEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutEmailIdentityFeedbackAttributesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutEmailIdentityFeedbackAttributesOutput = .{};

    return result;
}
