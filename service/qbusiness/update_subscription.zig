const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionType = @import("subscription_type.zig").SubscriptionType;
const SubscriptionDetails = @import("subscription_details.zig").SubscriptionDetails;

pub const UpdateSubscriptionInput = struct {
    /// The identifier of the Amazon Q Business application where the subscription
    /// update should take effect.
    application_id: []const u8,

    /// The identifier of the Amazon Q Business subscription to be updated.
    subscription_id: []const u8,

    /// The type of the Amazon Q Business subscription to be updated.
    @"type": SubscriptionType,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .subscription_id = "subscriptionId",
        .@"type" = "type",
    };
};

pub const UpdateSubscriptionOutput = struct {
    /// The type of your current Amazon Q Business subscription.
    current_subscription: ?SubscriptionDetails = null,

    /// The type of the Amazon Q Business subscription for the next month.
    next_subscription: ?SubscriptionDetails = null,

    /// The Amazon Resource Name (ARN) of the Amazon Q Business subscription that
    /// was updated.
    subscription_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_subscription = "currentSubscription",
        .next_subscription = "nextSubscription",
        .subscription_arn = "subscriptionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSubscriptionInput, options: CallOptions) !UpdateSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/subscriptions/");
    try path_buf.appendSlice(allocator, input.subscription_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSubscriptionOutput {
    const result: UpdateSubscriptionOutput = try aws.json.parseJsonObject(
        UpdateSubscriptionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
