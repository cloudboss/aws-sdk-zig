const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Subscriber = @import("subscriber.zig").Subscriber;
const Notification = @import("notification.zig").Notification;

pub const UpdateSubscriberInput = struct {
    /// The `accountId` that is associated with the budget whose subscriber you want
    /// to update.
    account_id: []const u8,

    /// The name of the budget whose subscriber you want to update.
    budget_name: []const u8,

    /// The updated subscriber that is associated with a budget notification.
    new_subscriber: Subscriber,

    /// The notification whose subscriber you want to update.
    notification: Notification,

    /// The previous subscriber that is associated with a budget notification.
    old_subscriber: Subscriber,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .budget_name = "BudgetName",
        .new_subscriber = "NewSubscriber",
        .notification = "Notification",
        .old_subscriber = "OldSubscriber",
    };
};

pub const UpdateSubscriberOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSubscriberInput, options: CallOptions) !UpdateSubscriberOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "budgets", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSubscriberInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("budgets", "Budgets", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBudgetServiceGateway.UpdateSubscriber");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSubscriberOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
