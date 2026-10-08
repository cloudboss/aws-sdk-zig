const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateAccountSettingsInput = struct {
    /// The ID for the Amazon Web Services account that contains the Quick Sight
    /// settings that you want to
    /// list.
    aws_account_id: []const u8,

    /// The default namespace for this Amazon Web Services account. Currently, the
    /// default is
    /// `default`. IAM users that
    /// register for the first time with Amazon Quick Sight provide an email address
    /// that becomes
    /// associated with the default namespace.
    default_namespace: []const u8,

    /// The email address that you want Quick Sight to send notifications to
    /// regarding your
    /// Amazon Web Services account or Quick Sight subscription.
    notification_email: ?[]const u8 = null,

    /// A boolean value that determines whether or not an Quick Sight account can be
    /// deleted. A `True` value doesn't allow the account to be deleted and results
    /// in an error message if a user tries to make a `DeleteAccountSubscription`
    /// request. A `False` value will allow the account to be deleted.
    termination_protection_enabled: ?bool = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .default_namespace = "DefaultNamespace",
        .notification_email = "NotificationEmail",
        .termination_protection_enabled = "TerminationProtectionEnabled",
    };
};

pub const UpdateAccountSettingsOutput = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccountSettingsInput, options: CallOptions) !UpdateAccountSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccountSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/settings");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DefaultNamespace\":");
    try aws.json.writeValue(@TypeOf(input.default_namespace), input.default_namespace, allocator, &body_buf);
    has_prev = true;
    if (input.notification_email) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NotificationEmail\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.termination_protection_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TerminationProtectionEnabled\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccountSettingsOutput {
    var result: UpdateAccountSettingsOutput = try aws.json.parseJsonObject(
        UpdateAccountSettingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
