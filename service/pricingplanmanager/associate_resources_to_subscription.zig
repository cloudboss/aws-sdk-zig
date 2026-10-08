const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Subscription = @import("subscription.zig").Subscription;

pub const AssociateResourcesToSubscriptionInput = struct {
    /// The ARN of the subscription to add resources to.
    arn: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the request
    /// is handled only once.
    client_token: ?[]const u8 = null,

    /// The `ETag` value from a previous `GetSubscription` or `ListSubscriptions`
    /// response.
    if_match: []const u8,

    /// The ARNs of the resources to add to the subscription.
    resource_arns: []const []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .if_match = "ifMatch",
        .resource_arns = "resourceArns",
    };
};

pub const AssociateResourcesToSubscriptionOutput = struct {
    /// The updated entity tag for concurrency control.
    e_tag: []const u8,

    /// The details of the subscription with the newly added resources.
    subscription: ?Subscription = null,

    pub const json_field_names = .{
        .e_tag = "eTag",
        .subscription = "subscription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateResourcesToSubscriptionInput, options: CallOptions) !AssociateResourcesToSubscriptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateResourcesToSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pricingplanmanager", "Pricing Plan Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/AssociateResourcesToSubscription";

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
    try body_buf.appendSlice(allocator, "\"resourceArns\":");
    try aws.json.writeValue(@TypeOf(input.resource_arns), input.resource_arns, allocator, &body_buf);
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
    try request.headers.put(allocator, "If-Match", input.if_match);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateResourcesToSubscriptionOutput {
    var result: AssociateResourcesToSubscriptionOutput = .{
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
