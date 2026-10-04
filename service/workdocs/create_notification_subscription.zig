const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionProtocolType = @import("subscription_protocol_type.zig").SubscriptionProtocolType;
const SubscriptionType = @import("subscription_type.zig").SubscriptionType;
const Subscription = @import("subscription.zig").Subscription;

pub const CreateNotificationSubscriptionInput = struct {
    /// The endpoint to receive the notifications. If the protocol is HTTPS, the
    /// endpoint
    /// is a URL that begins with `https`.
    endpoint: []const u8,

    /// The ID of the organization.
    organization_id: []const u8,

    /// The protocol to use. The supported value is https, which delivers
    /// JSON-encoded
    /// messages using HTTPS POST.
    protocol: SubscriptionProtocolType,

    /// The notification type.
    subscription_type: SubscriptionType,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
        .organization_id = "OrganizationId",
        .protocol = "Protocol",
        .subscription_type = "SubscriptionType",
    };
};

pub const CreateNotificationSubscriptionOutput = struct {
    /// The subscription.
    subscription: ?Subscription = null,

    pub const json_field_names = .{
        .subscription = "Subscription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNotificationSubscriptionInput, options: CallOptions) !CreateNotificationSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workdocs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNotificationSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workdocs", "WorkDocs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/organizations/");
    try path_buf.appendSlice(allocator, input.organization_id);
    try path_buf.appendSlice(allocator, "/subscriptions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Endpoint\":");
    try aws.json.writeValue(@TypeOf(input.endpoint), input.endpoint, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Protocol\":");
    try aws.json.writeValue(@TypeOf(input.protocol), input.protocol, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SubscriptionType\":");
    try aws.json.writeValue(@TypeOf(input.subscription_type), input.subscription_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNotificationSubscriptionOutput {
    const result: CreateNotificationSubscriptionOutput = try aws.json.parseJsonObject(
        CreateNotificationSubscriptionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
