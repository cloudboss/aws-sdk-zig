const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WhatsAppSetupFinalization = @import("whats_app_setup_finalization.zig").WhatsAppSetupFinalization;
const WhatsAppSignupCallback = @import("whats_app_signup_callback.zig").WhatsAppSignupCallback;
const WhatsAppSignupCallbackResult = @import("whats_app_signup_callback_result.zig").WhatsAppSignupCallbackResult;

pub const AssociateWhatsAppBusinessAccountInput = struct {
    /// A JSON object that contains the phone numbers and WhatsApp Business Account
    /// to link to your account.
    setup_finalization: ?WhatsAppSetupFinalization = null,

    /// Contains the callback access token.
    signup_callback: ?WhatsAppSignupCallback = null,

    pub const json_field_names = .{
        .setup_finalization = "setupFinalization",
        .signup_callback = "signupCallback",
    };
};

pub const AssociateWhatsAppBusinessAccountOutput = struct {
    /// The ID of the WhatsApp Business Account that was linked to your Amazon Web
    /// Services account.
    linked_whats_app_business_account_id: ?[]const u8 = null,

    /// Contains your WhatsApp registration status.
    signup_callback_result: ?WhatsAppSignupCallbackResult = null,

    /// The status code for the response.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .linked_whats_app_business_account_id = "linkedWhatsAppBusinessAccountId",
        .signup_callback_result = "signupCallbackResult",
        .status_code = "statusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateWhatsAppBusinessAccountInput, options: CallOptions) !AssociateWhatsAppBusinessAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "social-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateWhatsAppBusinessAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/signup";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.setup_finalization) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"setupFinalization\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.signup_callback) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"signupCallback\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateWhatsAppBusinessAccountOutput {
    const result: AssociateWhatsAppBusinessAccountOutput = try aws.json.parseJsonObject(
        AssociateWhatsAppBusinessAccountOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
