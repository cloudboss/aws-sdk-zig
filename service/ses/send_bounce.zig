const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BouncedRecipientInfo = @import("bounced_recipient_info.zig").BouncedRecipientInfo;
const MessageDsn = @import("message_dsn.zig").MessageDsn;
const serde = @import("serde.zig");

pub const SendBounceInput = struct {
    /// A list of recipients of the bounced message, including the information
    /// required to
    /// create the Delivery Status Notifications (DSNs) for the recipients. You must
    /// specify at
    /// least one `BouncedRecipientInfo` in the list.
    bounced_recipient_info_list: []const BouncedRecipientInfo,

    /// The address to use in the "From" header of the bounce message. This must be
    /// an
    /// identity that you have verified with Amazon SES.
    bounce_sender: []const u8,

    /// This parameter is used only for sending authorization. It is the ARN of the
    /// identity
    /// that is associated with the sending authorization policy that permits you to
    /// use the
    /// address in the "From" header of the bounce. For more information about
    /// sending
    /// authorization, see the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization.html).
    bounce_sender_arn: ?[]const u8 = null,

    /// Human-readable text for the bounce message to explain the failure. If not
    /// specified,
    /// the text is auto-generated based on the bounced recipient information.
    explanation: ?[]const u8 = null,

    /// Message-related DSN fields. If not specified, Amazon SES chooses the values.
    message_dsn: ?MessageDsn = null,

    /// The message ID of the message to be bounced.
    original_message_id: []const u8,
};

pub const SendBounceOutput = struct {
    /// The message ID of the bounce message.
    message_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendBounceInput, options: CallOptions) !SendBounceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendBounceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SendBounce&Version=2010-12-01");
    for (input.bounced_recipient_info_list, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.bounce_type) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BouncedRecipientInfoList.member.{d}.BounceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BouncedRecipientInfoList.member.{d}.Recipient=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.recipient);
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.recipient_arn) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BouncedRecipientInfoList.member.{d}.RecipientArn=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        if (item.recipient_dsn_fields) |sv_1| {
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BouncedRecipientInfoList.member.{d}.RecipientDsnFields.Action=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.action.wireName());
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (sv_1.diagnostic_code) |fv_2| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BouncedRecipientInfoList.member.{d}.RecipientDsnFields.DiagnosticCode=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                }
            }
            if (sv_1.extension_fields) |lst_2| {
                for (lst_2, 0..) |item_2, idx_2| {
                    const n_2 = idx_2 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BouncedRecipientInfoList.member.{d}.RecipientDsnFields.ExtensionFields.member.{d}.Name=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.name);
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BouncedRecipientInfoList.member.{d}.RecipientDsnFields.ExtensionFields.member.{d}.Value=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.value);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (sv_1.final_recipient) |fv_2| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BouncedRecipientInfoList.member.{d}.RecipientDsnFields.FinalRecipient=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (sv_1.last_attempt_date) |fv_2| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BouncedRecipientInfoList.member.{d}.RecipientDsnFields.LastAttemptDate=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (sv_1.remote_mta) |fv_2| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BouncedRecipientInfoList.member.{d}.RecipientDsnFields.RemoteMta=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BouncedRecipientInfoList.member.{d}.RecipientDsnFields.Status=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.status);
            }
        }
    }
    try body_buf.appendSlice(allocator, "&BounceSender=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.bounce_sender);
    if (input.bounce_sender_arn) |v| {
        try body_buf.appendSlice(allocator, "&BounceSenderArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.explanation) |v| {
        try body_buf.appendSlice(allocator, "&Explanation=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.message_dsn) |v| {
        if (v.arrival_date) |sv| {
            try body_buf.appendSlice(allocator, "&MessageDsn.ArrivalDate=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.extension_fields) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MessageDsn.ExtensionFields.member.{d}.Name=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MessageDsn.ExtensionFields.member.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
                }
            }
        }
        try body_buf.appendSlice(allocator, "&MessageDsn.ReportingMta=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.reporting_mta);
    }
    try body_buf.appendSlice(allocator, "&OriginalMessageId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.original_message_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendBounceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SendBounceResult")) break;
            },
            else => {},
        }
    }

    var result: SendBounceOutput = .{};
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
