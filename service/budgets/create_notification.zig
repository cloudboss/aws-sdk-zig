const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Notification = @import("notification.zig").Notification;
const Subscriber = @import("subscriber.zig").Subscriber;

pub const CreateNotificationInput = struct {
    /// The `accountId` that is associated with the budget that you want to create a
    /// notification for.
    account_id: []const u8,

    /// The name of the budget that you want Amazon Web Services to notify you
    /// about. Budget names must be unique within an account.
    budget_name: []const u8,

    /// The notification that you want to create.
    notification: Notification,

    /// A list of subscribers that you want to associate with the notification. Each
    /// notification can have one SNS subscriber and up to 10 email subscribers.
    subscribers: []const Subscriber,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .budget_name = "BudgetName",
        .notification = "Notification",
        .subscribers = "Subscribers",
    };
};

pub const CreateNotificationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNotificationInput, options: CallOptions) !CreateNotificationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNotificationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBudgetServiceGateway.CreateNotification");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNotificationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
