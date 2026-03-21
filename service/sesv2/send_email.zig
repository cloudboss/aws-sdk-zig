const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EmailContent = @import("email_content.zig").EmailContent;
const Destination = @import("destination.zig").Destination;
const MessageTag = @import("message_tag.zig").MessageTag;
const ListManagementOptions = @import("list_management_options.zig").ListManagementOptions;

pub const SendEmailInput = struct {
    /// The name of the configuration set to use when sending the email.
    configuration_set_name: ?[]const u8 = null,

    /// An object that contains the body of the message. You can send either a
    /// Simple message,
    /// Raw message, or a Templated message.
    content: EmailContent,

    /// An object that contains the recipients of the email message.
    destination: ?Destination = null,

    /// A list of tags, in the form of name/value pairs, to apply to an email that
    /// you send
    /// using the `SendEmail` operation. Tags correspond to characteristics of the
    /// email that you define, so that you can publish email sending events.
    email_tags: ?[]const MessageTag = null,

    /// The ID of the multi-region endpoint (global-endpoint).
    endpoint_id: ?[]const u8 = null,

    /// The address that you want bounce and complaint notifications to be sent to.
    feedback_forwarding_email_address: ?[]const u8 = null,

    /// This parameter is used only for sending authorization. It is the ARN of the
    /// identity
    /// that is associated with the sending authorization policy that permits you to
    /// use the
    /// email address specified in the `FeedbackForwardingEmailAddress`
    /// parameter.
    ///
    /// For example, if the owner of example.com (which has ARN
    /// arn:aws:ses:us-east-1:123456789012:identity/example.com) attaches a policy
    /// to it that
    /// authorizes you to use feedback@example.com, then you would specify the
    /// `FeedbackForwardingEmailAddressIdentityArn` to be
    /// arn:aws:ses:us-east-1:123456789012:identity/example.com, and the
    /// `FeedbackForwardingEmailAddress` to be feedback@example.com.
    ///
    /// For more information about sending authorization, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html).
    feedback_forwarding_email_address_identity_arn: ?[]const u8 = null,

    /// The email address to use as the "From" address for the email. The address
    /// that you
    /// specify has to be verified.
    from_email_address: ?[]const u8 = null,

    /// This parameter is used only for sending authorization. It is the ARN of the
    /// identity
    /// that is associated with the sending authorization policy that permits you to
    /// use the
    /// email address specified in the `FromEmailAddress` parameter.
    ///
    /// For example, if the owner of example.com (which has ARN
    /// arn:aws:ses:us-east-1:123456789012:identity/example.com) attaches a policy
    /// to it that
    /// authorizes you to use sender@example.com, then you would specify the
    /// `FromEmailAddressIdentityArn` to be
    /// arn:aws:ses:us-east-1:123456789012:identity/example.com, and the
    /// `FromEmailAddress` to be sender@example.com.
    ///
    /// For more information about sending authorization, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html).
    ///
    /// For Raw emails, the `FromEmailAddressIdentityArn` value overrides the
    /// X-SES-SOURCE-ARN and X-SES-FROM-ARN headers specified in raw email message
    /// content.
    from_email_address_identity_arn: ?[]const u8 = null,

    /// An object used to specify a list or topic to which an email belongs, which
    /// will be
    /// used when a contact chooses to unsubscribe.
    list_management_options: ?ListManagementOptions = null,

    /// The "Reply-to" email addresses for the message. When the recipient replies
    /// to the
    /// message, each Reply-to address receives the reply.
    reply_to_addresses: ?[]const []const u8 = null,

    /// The name of the tenant through which this email will be sent.
    ///
    /// The email sending operation will only succeed if all referenced resources
    /// (identities, configuration sets, and templates) are associated with this
    /// tenant.
    tenant_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .content = "Content",
        .destination = "Destination",
        .email_tags = "EmailTags",
        .endpoint_id = "EndpointId",
        .feedback_forwarding_email_address = "FeedbackForwardingEmailAddress",
        .feedback_forwarding_email_address_identity_arn = "FeedbackForwardingEmailAddressIdentityArn",
        .from_email_address = "FromEmailAddress",
        .from_email_address_identity_arn = "FromEmailAddressIdentityArn",
        .list_management_options = "ListManagementOptions",
        .reply_to_addresses = "ReplyToAddresses",
        .tenant_name = "TenantName",
    };
};

pub const SendEmailOutput = struct {
    /// A unique identifier for the message that is generated when the message is
    /// accepted.
    ///
    /// It's possible for Amazon SES to accept a message without sending it. For
    /// example, this
    /// can happen when the message that you're trying to send has an attachment
    /// that
    /// contains a virus, or when you send a templated email that contains invalid
    /// personalization content.
    message_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_id = "MessageId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendEmailInput, options: CallOptions) !SendEmailOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendEmailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v2/email/outbound-emails";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.configuration_set_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConfigurationSetName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
    if (input.destination) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Destination\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.email_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EmailTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.endpoint_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EndpointId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.feedback_forwarding_email_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FeedbackForwardingEmailAddress\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.feedback_forwarding_email_address_identity_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FeedbackForwardingEmailAddressIdentityArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.from_email_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FromEmailAddress\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.from_email_address_identity_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FromEmailAddressIdentityArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.list_management_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ListManagementOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.reply_to_addresses) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReplyToAddresses\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tenant_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TenantName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendEmailOutput {
    var result: SendEmailOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SendEmailOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccountSuspendedException")) {
        return .{ .arena = arena, .kind = .{ .account_suspended_exception = .{
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SendingPausedException")) {
        return .{ .arena = arena, .kind = .{ .sending_paused_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
