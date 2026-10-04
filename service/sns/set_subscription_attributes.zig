const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetSubscriptionAttributesInput = struct {
    /// A map of attributes with their corresponding values.
    ///
    /// The following lists the names, descriptions, and values of the special
    /// request
    /// parameters that this action uses:
    ///
    /// * `DeliveryPolicy` – The policy that defines how Amazon SNS retries
    /// failed deliveries to HTTP/S endpoints.
    ///
    /// * `FilterPolicy` – The simple JSON object that lets your
    /// subscriber receive only a subset of messages, rather than receiving every
    /// message published to the topic.
    ///
    /// * `FilterPolicyScope` – This attribute lets you choose the
    /// filtering scope by using one of the following string value types:
    ///
    /// * `MessageAttributes` (default) – The filter is
    /// applied on the message attributes.
    ///
    /// * `MessageBody` – The filter is applied on the message
    /// body.
    ///
    /// * `RawMessageDelivery` – When set to `true`,
    /// enables raw message delivery to Amazon SQS or HTTP/S endpoints. This
    /// eliminates the
    /// need for the endpoints to process JSON formatting, which is otherwise
    /// created
    /// for Amazon SNS metadata.
    ///
    /// * `RedrivePolicy` – When specified, sends undeliverable messages to the
    ///   specified Amazon SQS dead-letter queue.
    /// Messages that can't be delivered due to client errors (for example, when the
    /// subscribed endpoint is unreachable)
    /// or server errors (for example, when the service that powers the subscribed
    /// endpoint becomes unavailable) are held
    /// in the dead-letter queue for further analysis or reprocessing.
    ///
    /// The following attribute applies only to Amazon Data Firehose delivery stream
    /// subscriptions:
    ///
    /// * `SubscriptionRoleArn` – The ARN of the IAM role that has the following:
    ///
    /// * Permission to write to the Firehose delivery stream
    ///
    /// * Amazon SNS listed as a trusted entity
    ///
    /// Specifying a valid ARN for this attribute is required for Firehose delivery
    /// stream subscriptions.
    /// For more information, see [Fanout
    /// to Firehose delivery
    /// streams](https://docs.aws.amazon.com/sns/latest/dg/sns-firehose-as-subscriber.html) in the *Amazon SNS Developer Guide*.
    attribute_name: []const u8,

    /// The new value for the attribute in JSON format.
    attribute_value: ?[]const u8 = null,

    /// The ARN of the subscription to modify.
    subscription_arn: []const u8,
};

pub const SetSubscriptionAttributesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetSubscriptionAttributesInput, options: CallOptions) !SetSubscriptionAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetSubscriptionAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetSubscriptionAttributes&Version=2010-03-31");
    try body_buf.appendSlice(allocator, "&AttributeName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.attribute_name);
    if (input.attribute_value) |v| {
        try body_buf.appendSlice(allocator, "&AttributeValue=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&SubscriptionArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.subscription_arn);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetSubscriptionAttributesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetSubscriptionAttributesOutput = .{};

    return result;
}
