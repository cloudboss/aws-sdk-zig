const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Subscription = @import("subscription.zig").Subscription;

pub const UpdateSubscriptionInput = struct {
    /// The ARN of the subscription to update.
    arn: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the request
    /// is handled only once.
    client_token: ?[]const u8 = null,

    /// The `ETag` value from a previous `GetSubscription` or `ListSubscriptions`
    /// response. This ensures you are updating the expected version of the
    /// subscription.
    if_match: []const u8,

    /// The new tier level for the subscription.
    plan_tier: []const u8,

    /// The usage level within the plan tier. Specify `DEFAULT` for the base
    /// configuration. If omitted, the usage level is reset to the default.
    usage_level: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .if_match = "ifMatch",
        .plan_tier = "planTier",
        .usage_level = "usageLevel",
    };
};

pub const UpdateSubscriptionOutput = struct {
    /// The updated entity tag for concurrency control.
    e_tag: []const u8,

    /// The details of the updated subscription. For downgrades, the current tier
    /// remains unchanged and a `scheduledChange` indicates the pending change.
    subscription: ?Subscription = null,

    pub const json_field_names = .{
        .e_tag = "eTag",
        .subscription = "subscription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSubscriptionInput, options: CallOptions) !UpdateSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pricingplanmanager", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("pricingplanmanager", "Pricing Plan Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/UpdateSubscription";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"planTier\":");
    try aws.json.writeValue(@TypeOf(input.plan_tier), input.plan_tier, allocator, &body_buf);
    has_prev = true;
    if (input.usage_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"usageLevel\":");
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
    try request.headers.put(allocator, "If-Match", input.if_match);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSubscriptionOutput {
    var result: UpdateSubscriptionOutput = .{
        .e_tag = "",
    };
    errdefer {
        allocator.free(result.e_tag);
    }
    _ = body;
    _ = status;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}
