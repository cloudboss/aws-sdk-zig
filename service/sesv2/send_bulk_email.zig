const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BulkEmailEntry = @import("bulk_email_entry.zig").BulkEmailEntry;
const ConfigurationOverrides = @import("configuration_overrides.zig").ConfigurationOverrides;
const BulkEmailContent = @import("bulk_email_content.zig").BulkEmailContent;
const MessageTag = @import("message_tag.zig").MessageTag;
const BulkEmailEntryResult = @import("bulk_email_entry_result.zig").BulkEmailEntryResult;

pub const SendBulkEmailInput = struct {
    /// The list of bulk email entry objects.
    bulk_email_entries: []const BulkEmailEntry,

    /// An object that overrides, for the messages in this request only, settings
    /// that would
    /// otherwise apply to them. The overrides apply to every message in the
    /// request. Each
    /// setting that you don't override keeps the value that already applies.
    configuration_overrides: ?ConfigurationOverrides = null,

    /// The name of the configuration set to use when sending the email.
    configuration_set_name: ?[]const u8 = null,

    /// An object that contains the body of the message. You can specify a template
    /// message.
    default_content: BulkEmailContent,

    /// A list of tags, in the form of name/value pairs, to apply to an email that
    /// you send
    /// using the `SendEmail` operation. Tags correspond to characteristics of the
    /// email that you define, so that you can publish email sending events.
    default_email_tags: ?[]const MessageTag = null,

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
    from_email_address_identity_arn: ?[]const u8 = null,

    /// The "Reply-to" email addresses for the message. When the recipient replies
    /// to the
    /// message, each Reply-to address receives the reply.
    reply_to_addresses: ?[]const []const u8 = null,

    /// The name of the tenant through which this bulk email will be sent.
    ///
    /// The email sending operation will only succeed if all referenced resources
    /// (identities, configuration sets, and templates) are associated with this
    /// tenant.
    tenant_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .bulk_email_entries = "BulkEmailEntries",
        .configuration_overrides = "ConfigurationOverrides",
        .configuration_set_name = "ConfigurationSetName",
        .default_content = "DefaultContent",
        .default_email_tags = "DefaultEmailTags",
        .endpoint_id = "EndpointId",
        .feedback_forwarding_email_address = "FeedbackForwardingEmailAddress",
        .feedback_forwarding_email_address_identity_arn = "FeedbackForwardingEmailAddressIdentityArn",
        .from_email_address = "FromEmailAddress",
        .from_email_address_identity_arn = "FromEmailAddressIdentityArn",
        .reply_to_addresses = "ReplyToAddresses",
        .tenant_name = "TenantName",
    };
};

pub const SendBulkEmailOutput = struct {
    /// One object per intended recipient. Check each response object and retry any
    /// messages
    /// with a failure status.
    bulk_email_entry_results: ?[]const BulkEmailEntryResult = null,

    pub const json_field_names = .{
        .bulk_email_entry_results = "BulkEmailEntryResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendBulkEmailInput, options: CallOptions) !SendBulkEmailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendBulkEmailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/outbound-bulk-emails";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BulkEmailEntries\":");
    try aws.json.writeValue(@TypeOf(input.bulk_email_entries), input.bulk_email_entries, allocator, &body_buf);
    has_prev = true;
    if (input.configuration_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConfigurationOverrides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configuration_set_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConfigurationSetName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DefaultContent\":");
    try aws.json.writeValue(@TypeOf(input.default_content), input.default_content, allocator, &body_buf);
    has_prev = true;
    if (input.default_email_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DefaultEmailTags\":");
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendBulkEmailOutput {
    const result: SendBulkEmailOutput = try aws.json.parseJsonObject(
        SendBulkEmailOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
