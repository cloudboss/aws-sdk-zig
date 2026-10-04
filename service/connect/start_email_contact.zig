const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InboundAdditionalRecipients = @import("inbound_additional_recipients.zig").InboundAdditionalRecipients;
const EmailAttachment = @import("email_attachment.zig").EmailAttachment;
const InboundEmailContent = @import("inbound_email_content.zig").InboundEmailContent;
const EmailAddressInfo = @import("email_address_info.zig").EmailAddressInfo;
const Reference = @import("reference.zig").Reference;
const SegmentAttributeValue = @import("segment_attribute_value.zig").SegmentAttributeValue;

pub const StartEmailContactInput = struct {
    /// The additional recipients address of the email.
    additional_recipients: ?InboundAdditionalRecipients = null,

    /// List of S3 presigned URLs of email attachments and their file name.
    attachments: ?[]const EmailAttachment = null,

    /// A custom key-value pair using an attribute map. The attributes are standard
    /// Amazon Connect attributes, and
    /// can be accessed in flows just like any other contact attributes.
    ///
    /// There can be up to 32,768 UTF-8 bytes across all key-value pairs per
    /// contact. Attribute keys can include only
    /// alphanumeric, dash, and underscore characters.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The identifier of the flow for initiating the emails. To see the
    /// ContactFlowId in the Amazon Connect admin website, on the navigation
    /// menu go to **Routing**, **Flows**. Choose the flow. On the
    /// flow page, under the name of the flow, choose **Show additional flow
    /// information**. The
    /// ContactFlowId is the last part of the ARN, shown here in bold:
    ///
    /// arn:aws:connect:us-west-2:xxxxxxxxxxxx:instance/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/contact-flow/**846ec553-a005-41c0-8341-xxxxxxxxxxxx**
    contact_flow_id: ?[]const u8 = null,

    /// A description of the email contact.
    description: ?[]const u8 = null,

    /// The email address associated with the Amazon Connect instance.
    destination_email_address: []const u8,

    /// The email message body to be sent to the newly created email.
    email_message: InboundEmailContent,

    /// The email address of the customer.
    from_email_address: EmailAddressInfo,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The name of a email that is shown to an agent in the Contact Control Panel
    /// (CCP).
    name: ?[]const u8 = null,

    /// A formatted URL that is shown to an agent in the Contact Control Panel
    /// (CCP). Emails can have the following
    /// reference types at the time of creation: `URL` | `NUMBER` | `STRING` |
    /// `DATE`. `EMAIL` | `EMAIL_MESSAGE` |`ATTACHMENT` are not a supported
    /// reference type during email creation.
    references: ?[]const aws.map.MapEntry(Reference) = null,

    /// The contactId that is related to this contact. Linking emails together by
    /// using `RelatedContactID`
    /// copies over contact attributes from the related email contact to the new
    /// email contact. All updates to user-defined
    /// attributes in the new email contact are limited to the individual contact
    /// ID. There are no limits to the number of
    /// contacts that can be linked by using `RelatedContactId`.
    related_contact_id: ?[]const u8 = null,

    /// A set of system defined key-value pairs stored on individual contact
    /// segments using an attribute map. The
    /// attributes are standard Amazon Connect attributes. They can be accessed in
    /// flows.
    ///
    /// Attribute keys can include only alphanumeric, -, and _.
    ///
    /// This field can be used to show channel subtype, such as `connect:Guide`.
    ///
    /// To set contact expiry, a `ValueMap` must be specified containing the integer
    /// number of minutes the
    /// contact will be active for before expiring, with `SegmentAttributes` like {
    /// `
    /// "connect:ContactExpiry": {"ValueMap" : { "ExpiryDuration": {
    /// "ValueInteger":135}}}}`.
    segment_attributes: ?[]const aws.map.MapEntry(SegmentAttributeValue) = null,

    pub const json_field_names = .{
        .additional_recipients = "AdditionalRecipients",
        .attachments = "Attachments",
        .attributes = "Attributes",
        .client_token = "ClientToken",
        .contact_flow_id = "ContactFlowId",
        .description = "Description",
        .destination_email_address = "DestinationEmailAddress",
        .email_message = "EmailMessage",
        .from_email_address = "FromEmailAddress",
        .instance_id = "InstanceId",
        .name = "Name",
        .references = "References",
        .related_contact_id = "RelatedContactId",
        .segment_attributes = "SegmentAttributes",
    };
};

pub const StartEmailContactOutput = struct {
    /// The identifier of this contact within the Amazon Connect instance.
    contact_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_id = "ContactId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartEmailContactInput, options: CallOptions) !StartEmailContactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartEmailContactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/contact/email";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_recipients) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdditionalRecipients\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.attachments) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Attachments\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.contact_flow_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContactFlowId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationEmailAddress\":");
    try aws.json.writeValue(@TypeOf(input.destination_email_address), input.destination_email_address, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EmailMessage\":");
    try aws.json.writeValue(@TypeOf(input.email_message), input.email_message, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FromEmailAddress\":");
    try aws.json.writeValue(@TypeOf(input.from_email_address), input.from_email_address, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
    has_prev = true;
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.references) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"References\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.related_contact_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RelatedContactId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.segment_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SegmentAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartEmailContactOutput {
    var result: StartEmailContactOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartEmailContactOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
