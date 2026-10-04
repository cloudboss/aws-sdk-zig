const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const GetTopicAttributesInput = struct {
    /// The ARN of the topic whose properties you want to get.
    topic_arn: []const u8,
};

pub const GetTopicAttributesOutput = struct {
    /// A map of the topic's attributes. Attributes in this map include the
    /// following:
    ///
    /// * `DeliveryPolicy` – The JSON serialization of the topic's
    /// delivery policy.
    ///
    /// * `DisplayName` – The human-readable name used in the
    /// `From` field for notifications to `email` and
    /// `email-json` endpoints. For subscription confirmation and
    /// unsubscribe confirmation emails, the sender name is always
    /// "Amazon Web Services Notifications" regardless of this attribute.
    ///
    /// * `EffectiveDeliveryPolicy` – The JSON serialization of the
    /// effective delivery policy, taking system defaults into account.
    ///
    /// * `MaximumMessageSize` – The maximum size, in bytes, of a
    /// message that can be published to the topic. Amazon SNS returns this
    /// attribute only if
    /// you explicitly set it. If Amazon SNS doesn't return it, the topic uses the
    /// default of
    /// `262144` (256 KiB).
    ///
    /// * `Owner` – The Amazon Web Services account ID of the topic's owner.
    ///
    /// * `Policy` – The JSON serialization of the topic's access
    /// control policy.
    ///
    /// * `SignatureVersion` – The signature version corresponds to
    /// the hashing algorithm used while creating the signature of the
    /// notifications,
    /// subscription confirmations, or unsubscribe confirmation messages sent by
    /// Amazon SNS.
    ///
    /// * By default, `SignatureVersion` is set to **1**. The signature is a
    ///   Base64-encoded
    /// **SHA1withRSA** signature.
    ///
    /// * When you set `SignatureVersion` to **2**. Amazon SNS uses a Base64-encoded
    ///   **SHA256withRSA** signature.
    ///
    /// If the API response does not include the
    /// `SignatureVersion` attribute, it means that the
    /// `SignatureVersion` for the topic has value **1**.
    ///
    /// * `SubscriptionsConfirmed` – The number of confirmed
    /// subscriptions for the topic.
    ///
    /// * `SubscriptionsDeleted` – The number of deleted subscriptions
    /// for the topic.
    ///
    /// * `SubscriptionsPending` – The number of subscriptions pending
    /// confirmation for the topic.
    ///
    /// * `TopicArn` – The topic's ARN.
    ///
    /// * `TracingConfig` – Tracing mode of an Amazon SNS topic. By default
    /// `TracingConfig` is set to `PassThrough`, and the topic
    /// passes through the tracing header it receives from an Amazon SNS publisher
    /// to its
    /// subscriptions. If set to `Active`, Amazon SNS will vend X-Ray segment data
    /// to topic owner account if the sampled flag in the tracing header is true.
    /// This
    /// is only supported on standard topics.
    ///
    /// The following attribute applies only to
    /// [server-side-encryption](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html):
    ///
    /// * `KmsMasterKeyId` - The ID of an Amazon Web Services managed customer
    ///   master key
    /// (CMK) for Amazon SNS or a custom CMK. For more information, see [Key
    /// Terms](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html#sse-key-terms). For more examples, see [KeyId](https://docs.aws.amazon.com/kms/latest/APIReference/API_DescribeKey.html#API_DescribeKey_RequestParameters) in the *Key Management Service API Reference*.
    ///
    /// The following attributes apply only to [FIFO
    /// topics](https://docs.aws.amazon.com/sns/latest/dg/sns-fifo-topics.html):
    ///
    /// * `ArchivePolicy` – The policy that sets the retention period
    /// for messages stored in the message archive of an Amazon SNS FIFO
    /// topic.
    ///
    /// * `BeginningArchiveTime` – The earliest starting point at
    /// which a message in the topic’s archive can be replayed from. This point in
    /// time
    /// is based on the configured message retention period set by the topic’s
    /// message
    /// archiving policy.
    ///
    /// * `ContentBasedDeduplication` – Enables content-based
    /// deduplication for FIFO topics.
    ///
    /// * By default, `ContentBasedDeduplication` is set to
    /// `false`. If you create a FIFO topic and this attribute is
    /// `false`, you must specify a value for the
    /// `MessageDeduplicationId` parameter for the
    /// [Publish](https://docs.aws.amazon.com/sns/latest/api/API_Publish.html)
    /// action.
    ///
    /// * When you set `ContentBasedDeduplication` to
    /// `true`, Amazon SNS uses a SHA-256 hash to
    /// generate the `MessageDeduplicationId` using the body of the
    /// message (but not the attributes of the message).
    ///
    /// (Optional) To override the generated value, you can specify a value
    /// for the `MessageDeduplicationId` parameter for the
    /// `Publish` action.
    ///
    /// * `FifoTopic` – When this is set to `true`, a FIFO
    /// topic is created.
    attributes: ?[]const aws.map.StringMapEntry = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTopicAttributesInput, options: CallOptions) !GetTopicAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTopicAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetTopicAttributes&Version=2010-03-31");
    try body_buf.appendSlice(allocator, "&TopicArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.topic_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTopicAttributesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetTopicAttributesResult")) break;
            },
            else => {},
        }
    }

    var result: GetTopicAttributesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Attributes")) {
                    result.attributes = try serde.deserializeTopicAttributesMap(allocator, &reader, "entry");
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
