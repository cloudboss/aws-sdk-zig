const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Endpoint = @import("endpoint.zig").Endpoint;
const QueueInfoInput = @import("queue_info_input.zig").QueueInfoInput;
const Reference = @import("reference.zig").Reference;
const SegmentAttributeValue = @import("segment_attribute_value.zig").SegmentAttributeValue;
const UserInfo = @import("user_info.zig").UserInfo;

pub const UpdateContactInput = struct {
    /// The identifier of the contact. This is the identifier of the contact
    /// associated with the first interaction with
    /// your contact center.
    contact_id: []const u8,

    /// The endpoint of the customer for which the contact was initiated. For
    /// external audio contacts, this is usually
    /// the end customer's phone number. This value can only be updated for external
    /// audio contacts. For more information,
    /// see [Connect Customer
    /// Contact Lens
    /// integration](https://docs.aws.amazon.com/connect/latest/adminguide/contact-lens-integration.html) in the *Connect Customer Administrator Guide*.
    customer_endpoint: ?Endpoint = null,

    /// The description of the contact.
    description: ?[]const u8 = null,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The name of the contact.
    name: ?[]const u8 = null,

    /// Information about the queue associated with a contact. This parameter can
    /// only be updated for external audio
    /// contacts. It is used when you integrate third-party systems with Contact
    /// Lens for analytics. For more information, see [Connect Customer Contact Lens
    /// integration](https://docs.aws.amazon.com/connect/latest/adminguide/contact-lens-integration.html) in
    /// the *
    /// Connect Customer Administrator Guide*.
    queue_info: ?QueueInfoInput = null,

    /// Well-formed data on contact, shown to agents on Contact Control Panel (CCP).
    references: ?[]const aws.map.MapEntry(Reference) = null,

    /// A set of system defined key-value pairs stored on individual contact
    /// segments (unique contact ID) using an
    /// attribute map. The attributes are standard Connect Customer attributes. They
    /// can be accessed in flows.
    ///
    /// Attribute keys can include only alphanumeric, -, and _.
    ///
    /// This field can be used to show channel subtype, such as `connect:Guide`.
    ///
    /// Contact Expiry, and user-defined attributes (String - String) that are
    /// defined in predefined attributes, can be
    /// updated by using the UpdateContact API.
    segment_attributes: ?[]const aws.map.MapEntry(SegmentAttributeValue) = null,

    /// External system endpoint for the contact was initiated. For external audio
    /// contacts, this is the phone number of
    /// the external system such as the contact center. This value can only be
    /// updated for external audio contacts. For more
    /// information, see [Connect Customer Contact Lens
    /// integration](https://docs.aws.amazon.com/connect/latest/adminguide/contact-lens-integration.html) in the *Connect Customer Administrator
    /// Guide*.
    system_endpoint: ?Endpoint = null,

    /// Information about the agent associated with a contact. This parameter can
    /// only be updated for external audio
    /// contacts. It is used when you integrate third-party systems with Contact
    /// Lens for analytics. For more information, see [Connect Customer Contact Lens
    /// integration](https://docs.aws.amazon.com/connect/latest/adminguide/contact-lens-integration.html) in
    /// the *
    /// Connect Customer Administrator Guide*.
    user_info: ?UserInfo = null,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .customer_endpoint = "CustomerEndpoint",
        .description = "Description",
        .instance_id = "InstanceId",
        .name = "Name",
        .queue_info = "QueueInfo",
        .references = "References",
        .segment_attributes = "SegmentAttributes",
        .system_endpoint = "SystemEndpoint",
        .user_info = "UserInfo",
    };
};

pub const UpdateContactOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContactInput, options: CallOptions) !UpdateContactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/contacts/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.contact_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.customer_endpoint) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CustomerEndpoint\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.queue_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueueInfo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.references) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"References\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.segment_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SegmentAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.system_endpoint) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SystemEndpoint\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UserInfo\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContactOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateContactOutput = .{};

    return result;
}
