const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub const SetSMSAttributesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetSMSAttributesInput, options: CallOptions) !SetSMSAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetSMSAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetSMSAttributes&Version=2010-03-31");
    for (input.attributes, 0..) |entry, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const key_prefix = std.fmt.bufPrint(&prefix_buf, "&attributes.entry.{d}.key=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, key_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, entry.key);
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const val_prefix = std.fmt.bufPrint(&prefix_buf, "&attributes.entry.{d}.value=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, val_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, entry.value);
        }
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetSMSAttributesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetSMSAttributesOutput = .{};

    return result;
}
