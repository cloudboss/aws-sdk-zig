const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventSubscription = @import("event_subscription.zig").EventSubscription;

pub const ModifyEventSubscriptionInput = struct {
    /// A Boolean value; set to **true** to activate the
    /// subscription.
    enabled: ?bool = null,

    /// A list of event categories for a source type that you want to subscribe to.
    /// Use the
    /// `DescribeEventCategories` action to see a list of event categories.
    event_categories: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic created for event
    /// notification.
    /// The ARN is created by Amazon SNS when you create a topic and subscribe to
    /// it.
    sns_topic_arn: ?[]const u8 = null,

    /// The type of DMS resource that generates the events you want to subscribe to.
    ///
    /// Valid values: replication-instance | replication-task
    source_type: ?[]const u8 = null,

    /// The name of the DMS event notification subscription to be modified.
    subscription_name: []const u8,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .event_categories = "EventCategories",
        .sns_topic_arn = "SnsTopicArn",
        .source_type = "SourceType",
        .subscription_name = "SubscriptionName",
    };
};

pub const ModifyEventSubscriptionOutput = struct {
    /// The modified event subscription.
    event_subscription: ?EventSubscription = null,

    pub const json_field_names = .{
        .event_subscription = "EventSubscription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyEventSubscriptionInput, options: CallOptions) !ModifyEventSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyEventSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.ModifyEventSubscription");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyEventSubscriptionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ModifyEventSubscriptionOutput, body, allocator);
}
