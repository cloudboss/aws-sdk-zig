const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetSubscriptionAttributesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetSubscriptionAttributesInput, options: Options) !GetSubscriptionAttributesOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetSubscriptionAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("sns", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetSubscriptionAttributes&Version=2010-03-31");
    try body_buf.appendSlice(alloc, "&SubscriptionArn=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.subscription_arn);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetSubscriptionAttributesOutput {
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
                    result.attributes = try serde.deserializeSubscriptionAttributesMap(&reader, alloc, "entry");
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";

    if (std.mem.eql(u8, error_code, "AuthorizationErrorException")) {
        return .{ .authorization_error_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BatchEntryIdsNotDistinctException")) {
        return .{ .batch_entry_ids_not_distinct_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BatchRequestTooLongException")) {
        return .{ .batch_request_too_long_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentAccessException")) {
        return .{ .concurrent_access_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "EmptyBatchRequestException")) {
        return .{ .empty_batch_request_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "EndpointDisabledException")) {
        return .{ .endpoint_disabled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "FilterPolicyLimitExceededException")) {
        return .{ .filter_policy_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .internal_error_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBatchEntryIdException")) {
        return .{ .invalid_batch_entry_id_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .invalid_parameter_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .invalid_parameter_value_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityException")) {
        return .{ .invalid_security_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .invalid_state_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .kms_access_denied_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .kms_disabled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .kms_invalid_state_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .kms_not_found_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSOptInRequired")) {
        return .{ .kms_opt_in_required = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingException")) {
        return .{ .kms_throttling_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .not_found_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "OptedOutException")) {
        return .{ .opted_out_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "PlatformApplicationDisabledException")) {
        return .{ .platform_application_disabled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplayLimitExceededException")) {
        return .{ .replay_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "StaleTagException")) {
        return .{ .stale_tag_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionLimitExceededException")) {
        return .{ .subscription_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        return .{ .tag_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        return .{ .tag_policy_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .throttled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyEntriesInBatchRequestException")) {
        return .{ .too_many_entries_in_batch_request_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TopicLimitExceededException")) {
        return .{ .topic_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "UserErrorException")) {
        return .{ .user_error_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .validation_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "VerificationException")) {
        return .{ .verification_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
