const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OutboundAdditionalRecipients = @import("outbound_additional_recipients.zig").OutboundAdditionalRecipients;
const EmailAddressInfo = @import("email_address_info.zig").EmailAddressInfo;
const OutboundEmailContent = @import("outbound_email_content.zig").OutboundEmailContent;

pub const StartOutboundEmailContactInput = struct {
    /// The additional recipients address of email in CC.
    additional_recipients: ?OutboundAdditionalRecipients = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The identifier of the contact in this instance of Amazon Connect.
    contact_id: []const u8,

    /// The email address of the customer.
    destination_email_address: EmailAddressInfo,

    /// The email message body to be sent to the newly created email.
    email_message: OutboundEmailContent,

    /// The email address associated with the Amazon Connect instance.
    from_email_address: ?EmailAddressInfo = null,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    pub const json_field_names = .{
        .additional_recipients = "AdditionalRecipients",
        .client_token = "ClientToken",
        .contact_id = "ContactId",
        .destination_email_address = "DestinationEmailAddress",
        .email_message = "EmailMessage",
        .from_email_address = "FromEmailAddress",
        .instance_id = "InstanceId",
    };
};

pub const StartOutboundEmailContactOutput = struct {
    /// The identifier of the contact in this instance of Amazon Connect.
    contact_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_id = "ContactId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartOutboundEmailContactInput, options: CallOptions) !StartOutboundEmailContactOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartOutboundEmailContactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/contact/outbound-email";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_recipients) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdditionalRecipients\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ContactId\":");
    try aws.json.writeValue(@TypeOf(input.contact_id), input.contact_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationEmailAddress\":");
    try aws.json.writeValue(@TypeOf(input.destination_email_address), input.destination_email_address, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EmailMessage\":");
    try aws.json.writeValue(@TypeOf(input.email_message), input.email_message, allocator, &body_buf);
    has_prev = true;
    if (input.from_email_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FromEmailAddress\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartOutboundEmailContactOutput {
    var result: StartOutboundEmailContactOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartOutboundEmailContactOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
