const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Destination = @import("destination.zig").Destination;
const Message = @import("message.zig").Message;
const MessageTag = @import("message_tag.zig").MessageTag;
const serde = @import("serde.zig");

pub const SendEmailInput = struct {
    /// The name of the configuration set to use when you send an email using
    /// `SendEmail`.
    configuration_set_name: ?[]const u8 = null,

    /// The destination for this email, composed of To:, CC:, and BCC: fields.
    destination: Destination,

    /// The message to be sent.
    message: Message,

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
    /// [RFC6531](https://tools.ietf.org/html/rfc6531). For this reason, the
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
    /// using `SendEmail`. Tags correspond to characteristics of the email that you
    /// define, so that you can publish email sending events.
    tags: ?[]const MessageTag = null,
};

pub const SendEmailOutput = struct {
    /// The unique message identifier returned from the `SendEmail` action.
    message_id: []const u8,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendEmailInput, options: CallOptions) !SendEmailOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendEmailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SendEmail&Version=2010-12-01");
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
    if (input.message.body.html) |sv2| {
        if (sv2.charset) |sv3| {
            try body_buf.appendSlice(allocator, "&Message.Body.Html.Charset=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv3);
        }
        try body_buf.appendSlice(allocator, "&Message.Body.Html.Data=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv2.data);
    }
    if (input.message.body.text) |sv2| {
        if (sv2.charset) |sv3| {
            try body_buf.appendSlice(allocator, "&Message.Body.Text.Charset=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv3);
        }
        try body_buf.appendSlice(allocator, "&Message.Body.Text.Data=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv2.data);
    }
    if (input.message.subject.charset) |sv2| {
        try body_buf.appendSlice(allocator, "&Message.Subject.Charset=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
    }
    try body_buf.appendSlice(allocator, "&Message.Subject.Data=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.message.subject.data);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendEmailOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SendEmailResult")) break;
            },
            else => {},
        }
    }

    var result: SendEmailOutput = .{};
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
