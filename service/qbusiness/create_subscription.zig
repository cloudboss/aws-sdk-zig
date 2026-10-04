const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionPrincipal = @import("subscription_principal.zig").SubscriptionPrincipal;
const SubscriptionType = @import("subscription_type.zig").SubscriptionType;
const SubscriptionDetails = @import("subscription_details.zig").SubscriptionDetails;

pub const CreateSubscriptionInput = struct {
    /// The identifier of the Amazon Q Business application the subscription should
    /// be added to.
    application_id: []const u8,

    /// A token that you provide to identify the request to create a subscription
    /// for your Amazon Q Business application.
    client_token: ?[]const u8 = null,

    /// The IAM Identity Center `UserId` or `GroupId` of a user or group in the IAM
    /// Identity Center instance connected to the Amazon Q Business application.
    principal: SubscriptionPrincipal,

    /// The type of Amazon Q Business subscription you want to create.
    @"type": SubscriptionType,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .client_token = "clientToken",
        .principal = "principal",
        .@"type" = "type",
    };
};

pub const CreateSubscriptionOutput = struct {
    /// The type of your current Amazon Q Business subscription.
    current_subscription: ?SubscriptionDetails = null,

    /// The type of the Amazon Q Business subscription for the next month.
    next_subscription: ?SubscriptionDetails = null,

    /// The Amazon Resource Name (ARN) of the Amazon Q Business subscription
    /// created.
    subscription_arn: ?[]const u8 = null,

    /// The identifier of the Amazon Q Business subscription created.
    subscription_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_subscription = "currentSubscription",
        .next_subscription = "nextSubscription",
        .subscription_arn = "subscriptionArn",
        .subscription_id = "subscriptionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSubscriptionInput, options: CallOptions) !CreateSubscriptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/subscriptions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"principal\":");
    try aws.json.writeValue(@TypeOf(input.principal), input.principal, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSubscriptionOutput {
    var result: CreateSubscriptionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSubscriptionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
