const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const serde = @import("serde.zig");

pub const SetSMSAttributesInput = struct {
    /// The default settings for sending SMS messages from your Amazon Web Services
    /// account. You can set
    /// values for the following attribute names:
    ///
    /// `MonthlySpendLimit` – The maximum amount in USD that you are willing to
    /// spend
    /// each month to send SMS messages. When Amazon SNS determines that sending an
    /// SMS message would
    /// incur a cost that exceeds this limit, it stops sending SMS messages within
    /// minutes.
    ///
    /// Amazon SNS stops sending SMS messages within minutes of the limit being
    /// crossed. During
    /// that interval, if you continue to send SMS messages, you will incur costs
    /// that
    /// exceed your limit.
    ///
    /// By default, the spend limit is set to the maximum allowed by Amazon SNS. If
    /// you want to
    /// raise the limit, submit an [SNS Limit Increase
    /// case](https://console.aws.amazon.com/support/home#/case/create?issueType=service-limit-increase&limitType=service-code-sns). For **New limit
    /// value**, enter your desired monthly spend limit. In the **Use Case
    /// Description** field, explain that you are requesting
    /// an SMS monthly spend limit increase.
    ///
    /// `DeliveryStatusIAMRole` – The ARN of the IAM role that allows Amazon SNS to
    /// write
    /// logs about SMS deliveries in CloudWatch Logs. For each SMS message that you
    /// send, Amazon SNS
    /// writes a log that includes the message price, the success or failure status,
    /// the reason
    /// for failure (if the message failed), the message dwell time, and other
    /// information.
    ///
    /// `DeliveryStatusSuccessSamplingRate` – The percentage of successful SMS
    /// deliveries for which Amazon SNS will write logs in CloudWatch Logs. The
    /// value can be an
    /// integer from 0 - 100. For example, to write logs only for failed deliveries,
    /// set this
    /// value to `0`. To write logs for 10% of your successful deliveries, set it to
    /// `10`.
    ///
    /// `DefaultSenderID` – A string, such as your business brand, that is displayed
    /// as the sender on the receiving device. Support for sender IDs varies by
    /// country. The
    /// sender ID can be 1 - 11 alphanumeric characters, and it must contain at
    /// least one
    /// letter.
    ///
    /// `DefaultSMSType` – The type of SMS message that you will send by default.
    /// You
    /// can assign the following values:
    ///
    /// * `Promotional` – (Default) Noncritical messages, such as marketing
    /// messages. Amazon SNS optimizes the message delivery to incur the lowest
    /// cost.
    ///
    /// * `Transactional` – Critical messages that support customer
    /// transactions, such as one-time passcodes for multi-factor authentication.
    /// Amazon SNS
    /// optimizes the message delivery to achieve the highest reliability.
    ///
    /// `UsageReportS3Bucket` – The name of the Amazon S3 bucket to receive daily
    /// SMS
    /// usage reports from Amazon SNS. Each day, Amazon SNS will deliver a usage
    /// report as a CSV file to
    /// the bucket. The report includes the following information for each SMS
    /// message that was
    /// successfully delivered by your Amazon Web Services account:
    ///
    /// * Time that the message was published (in UTC)
    ///
    /// * Message ID
    ///
    /// * Destination phone number
    ///
    /// * Message type
    ///
    /// * Delivery status
    ///
    /// * Message price (in USD)
    ///
    /// * Part number (a message is split into multiple parts if it is too long for
    ///   a
    /// single message)
    ///
    /// * Total number of parts
    ///
    /// To receive the report, the bucket must have a policy that allows the Amazon
    /// SNS service
    /// principal to perform the `s3:PutObject` and `s3:GetBucketLocation`
    /// actions.
    ///
    /// For an example bucket policy and usage report, see [Monitoring SMS
    /// Activity](https://docs.aws.amazon.com/sns/latest/dg/sms_stats.html) in the
    /// *Amazon SNS Developer Guide*.
    attributes: []const aws.map.StringMapEntry,
};

pub const SetSMSAttributesOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetSMSAttributesInput, options: Options) !SetSMSAttributesOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: SetSMSAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=SetSMSAttributes&Version=2010-03-31");
    for (input.attributes, 0..) |entry, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const key_prefix = std.fmt.bufPrint(&prefix_buf, "&attributes.entry.{d}.key=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, key_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, entry.key);
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const val_prefix = std.fmt.bufPrint(&prefix_buf, "&attributes.entry.{d}.value=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, val_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, entry.value);
        }
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !SetSMSAttributesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: SetSMSAttributesOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AuthorizationErrorException")) {
        return .{ .arena = arena, .kind = .{ .authorization_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchEntryIdsNotDistinctException")) {
        return .{ .arena = arena, .kind = .{ .batch_entry_ids_not_distinct_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchRequestTooLongException")) {
        return .{ .arena = arena, .kind = .{ .batch_request_too_long_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentAccessException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_access_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EmptyBatchRequestException")) {
        return .{ .arena = arena, .kind = .{ .empty_batch_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointDisabledException")) {
        return .{ .arena = arena, .kind = .{ .endpoint_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FilterPolicyLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .filter_policy_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBatchEntryIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_batch_entry_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityException")) {
        return .{ .arena = arena, .kind = .{ .invalid_security_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSOptInRequired")) {
        return .{ .arena = arena, .kind = .{ .kms_opt_in_required = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .kms_throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptedOutException")) {
        return .{ .arena = arena, .kind = .{ .opted_out_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PlatformApplicationDisabledException")) {
        return .{ .arena = arena, .kind = .{ .platform_application_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplayLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .replay_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StaleTagException")) {
        return .{ .arena = arena, .kind = .{ .stale_tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .subscription_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        return .{ .arena = arena, .kind = .{ .tag_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyEntriesInBatchRequestException")) {
        return .{ .arena = arena, .kind = .{ .too_many_entries_in_batch_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TopicLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .topic_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserErrorException")) {
        return .{ .arena = arena, .kind = .{ .user_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VerificationException")) {
        return .{ .arena = arena, .kind = .{ .verification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
