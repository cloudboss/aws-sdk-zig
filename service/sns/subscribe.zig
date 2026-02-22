const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const serde = @import("serde.zig");

pub const SubscribeInput = struct {
    /// A map of attributes with their corresponding values.
    ///
    /// The following lists the names, descriptions, and values of the special
    /// request
    /// parameters that the `Subscribe` action uses:
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
    ///
    /// The following attributes apply only to [FIFO
    /// topics](https://docs.aws.amazon.com/sns/latest/dg/sns-fifo-topics.html):
    ///
    /// * `ReplayPolicy` – Adds or updates an inline policy document
    /// for a subscription to replay messages stored in the specified Amazon SNS
    /// topic.
    ///
    /// * `ReplayStatus` – Retrieves the status of the subscription
    /// message replay, which can be one of the following:
    ///
    /// * `Completed` – The replay has successfully
    /// redelivered all messages, and is now delivering newly published
    /// messages. If an ending point was specified in the
    /// `ReplayPolicy` then the subscription will no longer
    /// receive newly published messages.
    ///
    /// * `In progress` – The replay is currently replaying
    /// the selected messages.
    ///
    /// * `Failed` – The replay was unable to complete.
    ///
    /// * `Pending` – The default state while the replay
    /// initiates.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The endpoint that you want to receive notifications. Endpoints vary by
    /// protocol:
    ///
    /// * For the `http` protocol, the (public) endpoint is a URL beginning
    /// with `http://`.
    ///
    /// * For the `https` protocol, the (public) endpoint is a URL beginning
    /// with `https://`.
    ///
    /// * For the `email` protocol, the endpoint is an email address.
    ///
    /// * For the `email-json` protocol, the endpoint is an email
    /// address.
    ///
    /// * For the `sms` protocol, the endpoint is a phone number of an
    /// SMS-enabled device.
    ///
    /// * For the `sqs` protocol, the endpoint is the ARN of an Amazon SQS
    /// queue.
    ///
    /// * For the `application` protocol, the endpoint is the EndpointArn of
    /// a mobile app and device.
    ///
    /// * For the `lambda` protocol, the endpoint is the ARN of an Lambda
    /// function.
    ///
    /// * For the `firehose` protocol, the endpoint is the ARN of an Amazon
    /// Data Firehose delivery stream.
    endpoint: ?[]const u8 = null,

    /// The protocol that you want to use. Supported protocols include:
    ///
    /// * `http` – delivery of JSON-encoded message via HTTP
    /// POST
    ///
    /// * `https` – delivery of JSON-encoded message via HTTPS
    /// POST
    ///
    /// * `email` – delivery of message via SMTP
    ///
    /// * `email-json` – delivery of JSON-encoded message via
    /// SMTP
    ///
    /// * `sms` – delivery of message via SMS
    ///
    /// * `sqs` – delivery of JSON-encoded message to an Amazon SQS
    /// queue
    ///
    /// * `application` – delivery of JSON-encoded message to an
    /// EndpointArn for a mobile app and device
    ///
    /// * `lambda` – delivery of JSON-encoded message to an Lambda
    /// function
    ///
    /// * `firehose` – delivery of JSON-encoded message to an Amazon
    /// Data Firehose delivery stream.
    protocol: []const u8,

    /// Sets whether the response from the `Subscribe` request includes the
    /// subscription ARN, even if the subscription is not yet confirmed.
    ///
    /// If you set this parameter to `true`, the response includes the ARN in all
    /// cases, even if the subscription is not yet confirmed. In addition to the ARN
    /// for
    /// confirmed subscriptions, the response also includes the `pending
    /// subscription` ARN value for subscriptions that aren't yet confirmed. A
    /// subscription becomes confirmed when the subscriber calls the
    /// `ConfirmSubscription` action with a confirmation token.
    ///
    /// The default value is `false`.
    return_subscription_arn: ?bool = null,

    /// The ARN of the topic you want to subscribe to.
    topic_arn: []const u8,
};

pub const SubscribeOutput = struct {
    /// The ARN of the subscription if it is confirmed, or the string "pending
    /// confirmation"
    /// if the subscription requires confirmation. However, if the API request
    /// parameter
    /// `ReturnSubscriptionArn` is true, then the value is always the
    /// subscription ARN, even if the subscription requires confirmation.
    subscription_arn: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *SubscribeOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: SubscribeInput, options: Options) !SubscribeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sns");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: SubscribeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=Subscribe&Version=2010-03-31");
    if (input.attributes) |entries| {
        for (entries, 0..) |entry, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const key_prefix = std.fmt.bufPrint(&prefix_buf, "&Attributes.entry.{d}.key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, key_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, entry.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const val_prefix = std.fmt.bufPrint(&prefix_buf, "&Attributes.entry.{d}.value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, val_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, entry.value);
            }
        }
    }
    if (input.endpoint) |v| {
        try body_buf.appendSlice(alloc, "&Endpoint=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&Protocol=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.protocol);
    if (input.return_subscription_arn) |v| {
        try body_buf.appendSlice(alloc, "&ReturnSubscriptionArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&TopicArn=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.topic_arn);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !SubscribeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SubscribeResult")) break;
            },
            else => {},
        }
    }

    var result: SubscribeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SubscriptionArn")) {
                    result.subscription_arn = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, request_id);
    errdefer alloc.free(owned_request_id);

    if (std.mem.eql(u8, error_code, "AuthorizationErrorException")) {
        return .{ .authorization_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "BatchEntryIdsNotDistinctException")) {
        return .{ .batch_entry_ids_not_distinct_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "BatchRequestTooLongException")) {
        return .{ .batch_request_too_long_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentAccessException")) {
        return .{ .concurrent_access_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "EmptyBatchRequestException")) {
        return .{ .empty_batch_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "EndpointDisabledException")) {
        return .{ .endpoint_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "FilterPolicyLimitExceededException")) {
        return .{ .filter_policy_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBatchEntryIdException")) {
        return .{ .invalid_batch_entry_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityException")) {
        return .{ .invalid_security_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .kms_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .kms_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .kms_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSOptInRequired")) {
        return .{ .kms_opt_in_required = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingException")) {
        return .{ .kms_throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "OptedOutException")) {
        return .{ .opted_out_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "PlatformApplicationDisabledException")) {
        return .{ .platform_application_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplayLimitExceededException")) {
        return .{ .replay_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "StaleTagException")) {
        return .{ .stale_tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionLimitExceededException")) {
        return .{ .subscription_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        return .{ .tag_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        return .{ .tag_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyEntriesInBatchRequestException")) {
        return .{ .too_many_entries_in_batch_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TopicLimitExceededException")) {
        return .{ .topic_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "UserErrorException")) {
        return .{ .user_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "VerificationException")) {
        return .{ .verification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }

    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
