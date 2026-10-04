const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WhatsAppCallPermissionAction = @import("whats_app_call_permission_action.zig").WhatsAppCallPermissionAction;
const WhatsAppCallPermission = @import("whats_app_call_permission.zig").WhatsAppCallPermission;

pub const GetWhatsAppCallPermissionInput = struct {
    /// The end user's phone number, in E.164 format, for which to retrieve the
    /// calling permission.
    destination_phone_number: ?[]const u8 = null,

    /// The business-scoped user identifier (BSUID) of the end user for which to
    /// retrieve the calling permission.
    end_user_bsuid: ?[]const u8 = null,

    /// The unique identifier of the business phone number for which to retrieve the
    /// calling permission. The phone number identifiers are formatted as
    /// `phone-number-id-01234567890123456789012345678901`.
    origination_phone_number_id: []const u8,

    pub const json_field_names = .{
        .destination_phone_number = "destinationPhoneNumber",
        .end_user_bsuid = "endUserBsuid",
        .origination_phone_number_id = "originationPhoneNumberId",
    };
};

pub const GetWhatsAppCallPermissionOutput = struct {
    /// The calling actions the business can take with the end user, and any limits
    /// that apply to each action.
    actions: ?[]const WhatsAppCallPermissionAction = null,

    /// The current calling permission state for the end user.
    permission: ?WhatsAppCallPermission = null,

    pub const json_field_names = .{
        .actions = "actions",
        .permission = "permission",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWhatsAppCallPermissionInput, options: CallOptions) !GetWhatsAppCallPermissionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWhatsAppCallPermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/call/permission/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.destination_phone_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"destinationPhoneNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.end_user_bsuid) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endUserBsuid\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"originationPhoneNumberId\":");
    try aws.json.writeValue(@TypeOf(input.origination_phone_number_id), input.origination_phone_number_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWhatsAppCallPermissionOutput {
    const result: GetWhatsAppCallPermissionOutput = try aws.json.parseJsonObject(
        GetWhatsAppCallPermissionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
