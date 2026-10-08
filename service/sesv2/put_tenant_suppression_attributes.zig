const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuppressionListReason = @import("suppression_list_reason.zig").SuppressionListReason;
const SuppressionListScope = @import("suppression_list_scope.zig").SuppressionListScope;

pub const PutTenantSuppressionAttributesInput = struct {
    /// A list that contains the reasons that email addresses are automatically
    /// added to the
    /// suppression list for the tenant. This list can contain any or all of the
    /// following:
    ///
    /// * `COMPLAINT` – Amazon SES adds an email address to the suppression
    /// list when a message sent to that address results in a complaint.
    ///
    /// * `BOUNCE` – Amazon SES adds an email address to the suppression
    /// list when a message sent to that address results in a hard bounce.
    suppressed_reasons: ?[]const SuppressionListReason = null,

    /// The suppression scope for the tenant. Specify `TENANT` to use the tenant's
    /// own suppression list, or `ACCOUNT` to use the account-level suppression
    /// list.
    ///
    /// If you don't specify a suppression scope, the tenant defaults to `ACCOUNT`
    /// scope
    /// and uses the account-level suppression list.
    suppression_scope: ?SuppressionListScope = null,

    /// The name of the tenant to configure suppression list preferences for.
    tenant_name: []const u8,

    pub const json_field_names = .{
        .suppressed_reasons = "SuppressedReasons",
        .suppression_scope = "SuppressionScope",
        .tenant_name = "TenantName",
    };
};

pub const PutTenantSuppressionAttributesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutTenantSuppressionAttributesInput, options: CallOptions) !PutTenantSuppressionAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutTenantSuppressionAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/tenant/suppression";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.suppressed_reasons) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SuppressedReasons\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.suppression_scope) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SuppressionScope\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TenantName\":");
    try aws.json.writeValue(@TypeOf(input.tenant_name), input.tenant_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutTenantSuppressionAttributesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutTenantSuppressionAttributesOutput = .{};

    return result;
}
