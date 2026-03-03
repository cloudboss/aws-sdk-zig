const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Destination = @import("destination.zig").Destination;
const MessageTag = @import("message_tag.zig").MessageTag;
const serde = @import("serde.zig");

pub const SendTemplatedEmailInput = struct {
    /// The name of the configuration set to use when you send an email using
    /// `SendTemplatedEmail`.
    configuration_set_name: ?[]const u8 = null,

    /// The destination for this email, composed of To:, CC:, and BCC: fields. A
    /// Destination
    /// can include up to 50 recipients across these three fields.
    destination: Destination,

    /// The reply-to email address(es) for the message. If the recipient replies to
    /// the
    /// message, each reply-to address receives the reply.
    reply_to_addresses: ?[]const []const u8 = null,

    /// The email address that bounces and complaints are forwarded to when feedback
    /// forwarding is enabled. If the message cannot be delivered to the recipient,
    /// then an
    /// error message is returned from the recipient's ISP; this message is
    /// forwarded to the
    /// email address specified by the `ReturnPath` parameter. The
    /// `ReturnPath` parameter is never overwritten. This email address must be
    /// either individually verified with Amazon SES, or from a domain that has been
    /// verified with
    /// Amazon SES.
    return_path: ?[]const u8 = null,

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
    /// For more information about sending authorization, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization.html).
    return_path_arn: ?[]const u8 = null,

    /// The email address that is sending the email. This email address must be
    /// either
    /// individually verified with Amazon SES, or from a domain that has been
    /// verified with Amazon SES.
    /// For information about verifying identities, see the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html).
    ///
    /// If you are sending on behalf of another user and have been permitted to do
    /// so by a
    /// sending authorization policy, then you must also specify the `SourceArn`
    /// parameter. For more information about sending authorization, see the [Amazon
    /// SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization.html).
    ///
    /// Amazon SES does not support the SMTPUTF8 extension, as described in
    /// [RFC6531](https://tools.ietf.org/html/rfc6531). for this reason, The
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
    source: []const u8,

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
    /// For more information about sending authorization, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization.html).
    source_arn: ?[]const u8 = null,

    /// A list of tags, in the form of name/value pairs, to apply to an email that
    /// you send
    /// using `SendTemplatedEmail`. Tags correspond to characteristics of the email
    /// that you define, so that you can publish email sending events.
    tags: ?[]const MessageTag = null,

    /// The template to use when sending this email.
    template: []const u8,

    /// The ARN of the template to use when sending this email.
    template_arn: ?[]const u8 = null,

    /// A list of replacement values to apply to the template. This parameter is a
    /// JSON
    /// object, typically consisting of key-value pairs in which the keys correspond
    /// to
    /// replacement tags in the email template.
    template_data: []const u8,
};

pub const SendTemplatedEmailOutput = struct {
    /// The unique message identifier returned from the `SendTemplatedEmail`
    /// action.
    message_id: []const u8,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendTemplatedEmailInput, options: CallOptions) !SendTemplatedEmailOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendTemplatedEmailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ses", "SES", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=SendTemplatedEmail&Version=2010-12-01");
    if (input.configuration_set_name) |v| {
        try body_buf.appendSlice(allocator, "&ConfigurationSetName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.destination.bcc_addresses) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Destination.BccAddresses.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.destination.cc_addresses) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Destination.CcAddresses.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.destination.to_addresses) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Destination.ToAddresses.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.reply_to_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReplyToAddresses.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.return_path) |v| {
        try body_buf.appendSlice(allocator, "&ReturnPath=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.return_path_arn) |v| {
        try body_buf.appendSlice(allocator, "&ReturnPathArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&Source=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source);
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
    try body_buf.appendSlice(allocator, "&Template=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.template);
    if (input.template_arn) |v| {
        try body_buf.appendSlice(allocator, "&TemplateArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&TemplateData=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.template_data);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendTemplatedEmailOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SendTemplatedEmailResult")) break;
            },
            else => {},
        }
    }

    var result: SendTemplatedEmailOutput = .{};
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
