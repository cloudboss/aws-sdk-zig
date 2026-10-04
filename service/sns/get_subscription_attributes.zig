const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const GetSubscriptionAttributesInput = struct {
    /// The ARN of the subscription whose properties you want to get.
    subscription_arn: []const u8,
};

pub const GetSubscriptionAttributesOutput = struct {
    /// A map of the subscription's attributes. Attributes in this map include the
    /// following:
    ///
    /// * `ConfirmationWasAuthenticated` – `true` if the
    /// subscription confirmation request was authenticated.
    ///
    /// * `DeliveryPolicy` – The JSON serialization of the
    /// subscription's delivery policy.
    ///
    /// * `EffectiveDeliveryPolicy` – The JSON serialization of the
    /// effective delivery policy that takes into account the topic delivery policy
    /// and
    /// account system defaults.
    ///
    /// * `FilterPolicy` – The filter policy JSON that is assigned to
    /// the subscription. For more information, see [Amazon SNS Message
    /// Filtering](https://docs.aws.amazon.com/sns/latest/dg/sns-message-filtering.html) in the *Amazon SNS Developer Guide*.
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
    /// * `Owner` – The Amazon Web Services account ID of the subscription's
    /// owner.
    ///
    /// * `PendingConfirmation` – `true` if the subscription
    /// hasn't been confirmed. To confirm a pending subscription, call the
    /// `ConfirmSubscription` action with a confirmation token.
    ///
    /// * `RawMessageDelivery` – `true` if raw message
    /// delivery is enabled for the subscription. Raw messages are free of JSON
    /// formatting and can be sent to HTTP/S and Amazon SQS endpoints.
    ///
    /// * `RedrivePolicy` – When specified, sends undeliverable messages to the
    ///   specified Amazon SQS dead-letter queue.
    /// Messages that can't be delivered due to client errors (for example, when the
    /// subscribed endpoint is unreachable)
    /// or server errors (for example, when the service that powers the subscribed
    /// endpoint becomes unavailable) are held
    /// in the dead-letter queue for further analysis or reprocessing.
    ///
    /// * `SubscriptionArn` – The subscription's ARN.
    ///
    /// * `TopicArn` – The topic ARN that the subscription is associated
    /// with.
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
    attributes: ?[]const aws.map.StringMapEntry = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSubscriptionAttributesInput, options: CallOptions) !GetSubscriptionAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSubscriptionAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetSubscriptionAttributes&Version=2010-03-31");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSubscriptionAttributesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetSubscriptionAttributesResult")) break;
            },
            else => {},
        }
    }

    var result: GetSubscriptionAttributesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Attributes")) {
                    result.attributes = try serde.deserializeSubscriptionAttributesMap(allocator, &reader, "entry");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
