const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RawMessage = @import("raw_message.zig").RawMessage;
const MessageTag = @import("message_tag.zig").MessageTag;
const serde = @import("serde.zig");

pub const SendRawEmailInput = struct {
    /// The name of the configuration set to use when you send an email using
    /// `SendRawEmail`.
    configuration_set_name: ?[]const u8 = null,

    /// A list of destinations for the message, consisting of To:, CC:, and BCC:
    /// addresses.
    destinations: ?[]const []const u8 = null,

    /// This parameter is used only for sending authorization. It is the ARN of the
    /// identity
    /// that is associated with the sending authorization policy that permits you to
    /// specify a
    /// particular "From" address in the header of the raw email.
    ///
    /// Instead of using this parameter, you can use the X-header `X-SES-FROM-ARN`
    /// in the raw message of the email. If you use both the `FromArn` parameter and
    /// the corresponding X-header, Amazon SES uses the value of the `FromArn`
    /// parameter.
    ///
    /// For information about when to use this parameter, see the description of
    /// `SendRawEmail` in this guide, or see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization-delegate-sender-tasks-email.html).
    from_arn: ?[]const u8 = null,

    /// The raw email message itself. The message has to meet the following
    /// criteria:
    ///
    /// * The message has to contain a header and a body, separated by a blank
    /// line.
    ///
    /// * All of the required header fields must be present in the message.
    ///
    /// * Each part of a multipart MIME message must be formatted properly.
    ///
    /// * Attachments must be of a content type that Amazon SES supports. For a list
    ///   on
    /// unsupported content types, see [Unsupported Attachment
    /// Types](https://docs.aws.amazon.com/ses/latest/dg/mime-types.html) in
    /// the *Amazon SES Developer Guide*.
    ///
    /// * The entire message must be base64-encoded.
    ///
    /// * If any of the MIME parts in your message contain content that is outside
    ///   of
    /// the 7-bit ASCII character range, we highly recommend that you encode that
    /// content. For more information, see [Sending Raw
    /// Email](https://docs.aws.amazon.com/ses/latest/dg/send-email-raw.html) in the
    /// *Amazon SES Developer Guide*.
    ///
    /// * Per [RFC
    /// 5321](https://tools.ietf.org/html/rfc5321#section-4.5.3.1.6), the maximum
    /// length of each line of text, including the
    /// , must not exceed 1,000 characters.
    raw_message: RawMessage,

    /// This parameter is used only for sending authorization. It is the ARN of the
    /// identity
    /// that is associated with the sending authorization policy that permits you to
    /// use the
    /// email address specified in the `ReturnPath` parameter.
    ///
    /// For example, if the owner of `example.com` (which has ARN
    /// `arn:aws:ses:us-east-1:123456789012:identity/example.com`) attaches a
    /// policy to it that authorizes you to use `feedback@example.com`, then you
    /// would specify the `ReturnPathArn` to be
    /// `arn:aws:ses:us-east-1:123456789012:identity/example.com`, and the
    /// `ReturnPath` to be `feedback@example.com`.
    ///
    /// Instead of using this parameter, you can use the X-header
    /// `X-SES-RETURN-PATH-ARN` in the raw message of the email. If you use both
    /// the `ReturnPathArn` parameter and the corresponding X-header, Amazon SES
    /// uses the
    /// value of the `ReturnPathArn` parameter.
    ///
    /// For information about when to use this parameter, see the description of
    /// `SendRawEmail` in this guide, or see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization-delegate-sender-tasks-email.html).
    return_path_arn: ?[]const u8 = null,

    /// The identity's email address. If you do not provide a value for this
    /// parameter, you
    /// must specify a "From" address in the raw text of the message. (You can also
    /// specify
    /// both.)
    ///
    /// Amazon SES does not support the SMTPUTF8 extension, as described
    /// in[RFC6531](https://tools.ietf.org/html/rfc6531). For this reason, the
    /// email address string must be 7-bit ASCII. If you want to send to or from
    /// email
    /// addresses that contain Unicode characters in the domain part of an address,
    /// you must
    /// encode the domain using Punycode. Punycode is not permitted in the local
    /// part of the
    /// email address (the part before the @ sign) nor in the "friendly from" name.
    /// If you
    /// want to use Unicode characters in the "friendly from" name, you must encode
    /// the
    /// "friendly from" name using MIME encoded-word syntax, as described in
    /// [Sending raw email
    /// using the Amazon SES
    /// API](https://docs.aws.amazon.com/ses/latest/dg/send-email-raw.html). For
    /// more information about Punycode, see [RFC
    /// 3492](http://tools.ietf.org/html/rfc3492).
    ///
    /// If you specify the `Source` parameter and have feedback forwarding enabled,
    /// then bounces and complaints are sent to this email address. This takes
    /// precedence over
    /// any Return-Path header that you might include in the raw text of the
    /// message.
    source: ?[]const u8 = null,

    /// This parameter is used only for sending authorization. It is the ARN of the
    /// identity
    /// that is associated with the sending authorization policy that permits you to
    /// send for
    /// the email address specified in the `Source` parameter.
    ///
    /// For example, if the owner of `example.com` (which has ARN
    /// `arn:aws:ses:us-east-1:123456789012:identity/example.com`) attaches a
    /// policy to it that authorizes you to send from `user@example.com`, then you
    /// would specify the `SourceArn` to be
    /// `arn:aws:ses:us-east-1:123456789012:identity/example.com`, and the
    /// `Source` to be `user@example.com`.
    ///
    /// Instead of using this parameter, you can use the X-header
    /// `X-SES-SOURCE-ARN` in the raw message of the email. If you use both the
    /// `SourceArn` parameter and the corresponding X-header, Amazon SES uses the
    /// value of the `SourceArn` parameter.
    ///
    /// For information about when to use this parameter, see the description of
    /// `SendRawEmail` in this guide, or see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization-delegate-sender-tasks-email.html).
    source_arn: ?[]const u8 = null,

    /// A list of tags, in the form of name/value pairs, to apply to an email that
    /// you send
    /// using `SendRawEmail`. Tags correspond to characteristics of the email that
    /// you define, so that you can publish email sending events.
    tags: ?[]const MessageTag = null,
};

pub const SendRawEmailOutput = struct {
    /// The unique message identifier returned from the `SendRawEmail` action.
    message_id: []const u8,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendRawEmailInput, options: CallOptions) !SendRawEmailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ses");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: SendRawEmailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=SendRawEmail&Version=2010-12-01");
    if (input.configuration_set_name) |v| {
        try body_buf.appendSlice(allocator, "&ConfigurationSetName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.destinations) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Destinations.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.from_arn) |v| {
        try body_buf.appendSlice(allocator, "&FromArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&RawMessage.Data=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.raw_message.data);
    if (input.return_path_arn) |v| {
        try body_buf.appendSlice(allocator, "&ReturnPathArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source) |v| {
        try body_buf.appendSlice(allocator, "&Source=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source_arn) |v| {
        try body_buf.appendSlice(allocator, "&SourceArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendRawEmailOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SendRawEmailResult")) break;
            },
            else => {},
        }
    }

    var result: SendRawEmailOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MessageId")) {
                    result.message_id = try allocator.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AccountSendingPausedException")) {
        return .{ .arena = arena, .kind = .{ .account_sending_paused_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CannotDeleteException")) {
        return .{ .arena = arena, .kind = .{ .cannot_delete_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConfigurationSetAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .configuration_set_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConfigurationSetDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .configuration_set_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConfigurationSetSendingPausedException")) {
        return .{ .arena = arena, .kind = .{ .configuration_set_sending_paused_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomVerificationEmailInvalidContentException")) {
        return .{ .arena = arena, .kind = .{ .custom_verification_email_invalid_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomVerificationEmailTemplateAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .custom_verification_email_template_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomVerificationEmailTemplateDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .custom_verification_email_template_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventDestinationAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .event_destination_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventDestinationDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .event_destination_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FromEmailAddressNotVerifiedException")) {
        return .{ .arena = arena, .kind = .{ .from_email_address_not_verified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCloudWatchDestinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_cloud_watch_destination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConfigurationSetException")) {
        return .{ .arena = arena, .kind = .{ .invalid_configuration_set_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDeliveryOptionsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_delivery_options_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFirehoseDestinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_firehose_destination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLambdaFunctionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_lambda_function_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRenderingParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_rendering_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3ConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSNSDestinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sns_destination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSnsTopicException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sns_topic_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTemplateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_template_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTrackingOptionsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tracking_options_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MailFromDomainNotVerifiedException")) {
        return .{ .arena = arena, .kind = .{ .mail_from_domain_not_verified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MessageRejected")) {
        return .{ .arena = arena, .kind = .{ .message_rejected = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingRenderingAttributeException")) {
        return .{ .arena = arena, .kind = .{ .missing_rendering_attribute_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProductionAccessNotGrantedException")) {
        return .{ .arena = arena, .kind = .{ .production_access_not_granted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuleDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .rule_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuleSetDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .rule_set_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TemplateDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .template_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrackingOptionsAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .tracking_options_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrackingOptionsDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .tracking_options_does_not_exist_exception = .{
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
