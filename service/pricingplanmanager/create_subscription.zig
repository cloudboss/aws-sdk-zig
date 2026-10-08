const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApprovalMode = @import("approval_mode.zig").ApprovalMode;
const Subscription = @import("subscription.zig").Subscription;

pub const CreateSubscriptionInput = struct {
    /// Determines whether the subscription requires explicit approval before
    /// billing starts. Set to `MANUAL` to require a separate
    /// `ApprovePaidSubscription` call, or `IMMEDIATE` to activate the subscription
    /// right away. For paid tier plans, this defaults to `MANUAL` if not specified.
    /// For the `FREE` plan tier, only `IMMEDIATE` is supported, and it is the
    /// default.
    approval_mode: ?ApprovalMode = null,

    /// A unique, case-sensitive identifier that you provide to ensure that the
    /// request is handled only once. If you send the same request with the same
    /// client token, the API returns the original response without creating a
    /// duplicate subscription.
    client_token: ?[]const u8 = null,

    /// The pricing plan family to subscribe to, such as `CloudFront`.
    plan_family: []const u8,

    /// The tier level for the subscription, such as `FREE`, `PRO`, `BUSINESS`, or
    /// `PREMIUM`.
    plan_tier: []const u8,

    /// The ARNs of the resources to include in the subscription. Specify one or
    /// more supported resources.
    ///
    /// For subscriptions in the CloudFront plan family, the resources must include
    /// exactly one Amazon CloudFront distribution and exactly one WAF web ACL. You
    /// can also include other supported resources, such as Amazon Route 53 hosted
    /// zones and CloudFront KeyValueStores.
    resource_arns: []const []const u8,

    /// The usage level within the plan tier. Specify `DEFAULT` for the base
    /// configuration, or a higher level if your plan tier supports it.
    usage_level: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_mode = "approvalMode",
        .client_token = "clientToken",
        .plan_family = "planFamily",
        .plan_tier = "planTier",
        .resource_arns = "resourceArns",
        .usage_level = "usageLevel",
    };
};

pub const CreateSubscriptionOutput = struct {
    /// The entity tag for concurrency control. Use this value in the `If-Match`
    /// header for subsequent operations on this subscription.
    e_tag: []const u8,

    /// The details of the newly created subscription.
    subscription: ?Subscription = null,

    pub const json_field_names = .{
        .e_tag = "eTag",
        .subscription = "subscription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSubscriptionInput, options: CallOptions) !CreateSubscriptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pricingplanmanager", "Pricing Plan Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/CreateSubscription";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.approval_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"approvalMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"planFamily\":");
    try aws.json.writeValue(@TypeOf(input.plan_family), input.plan_family, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"planTier\":");
    try aws.json.writeValue(@TypeOf(input.plan_tier), input.plan_tier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceArns\":");
    try aws.json.writeValue(@TypeOf(input.resource_arns), input.resource_arns, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSubscriptionOutput {
    var result: CreateSubscriptionOutput = .{
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
