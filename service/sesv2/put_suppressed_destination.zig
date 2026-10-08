const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuppressionListReason = @import("suppression_list_reason.zig").SuppressionListReason;

pub const PutSuppressedDestinationInput = struct {
    /// The email address that should be added to the suppression list for your
    /// account or
    /// for the specified tenant.
    email_address: []const u8,

    /// The factors that should cause the email address to be added to the
    /// suppression list
    /// for your account or for the specified tenant.
    reason: SuppressionListReason,

    /// The name of the tenant whose suppression list you want to add the address
    /// to. If you
    /// omit this parameter, the address is added to the account-level suppression
    /// list.
    tenant_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .email_address = "EmailAddress",
        .reason = "Reason",
        .tenant_name = "TenantName",
    };
};

pub const PutSuppressedDestinationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSuppressedDestinationInput, options: CallOptions) !PutSuppressedDestinationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSuppressedDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/suppression/addresses";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EmailAddress\":");
    try aws.json.writeValue(@TypeOf(input.email_address), input.email_address, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Reason\":");
    try aws.json.writeValue(@TypeOf(input.reason), input.reason, allocator, &body_buf);
    has_prev = true;
    if (input.tenant_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TenantName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSuppressedDestinationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutSuppressedDestinationOutput = .{};

    return result;
}
