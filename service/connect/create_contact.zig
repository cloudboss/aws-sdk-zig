const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Channel = @import("channel.zig").Channel;
const InitiateAs = @import("initiate_as.zig").InitiateAs;
const ContactInitiationMethod = @import("contact_initiation_method.zig").ContactInitiationMethod;
const Reference = @import("reference.zig").Reference;
const SegmentAttributeValue = @import("segment_attribute_value.zig").SegmentAttributeValue;
const UserInfo = @import("user_info.zig").UserInfo;

pub const CreateContactInput = struct {
    /// A custom key-value pair using an attribute map. The attributes are standard
    /// Connect Customer attributes, and
    /// can be accessed in flows just like any other contact attributes.
    ///
    /// There can be up to 32,768 UTF-8 bytes across all key-value pairs per
    /// contact. Attribute keys can include only
    /// alphanumeric, dash, and underscore characters.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The channel for the contact.
    ///
    /// The CHAT channel is not supported. The following information is incorrect.
    /// We're working to correct it.
    channel: Channel,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// A description of the contact.
    description: ?[]const u8 = null,

    /// Number of minutes the contact will be active for before expiring
    expiry_duration_in_minutes: ?i32 = null,

    /// Initial state of the contact when it's created. Only TASK channel contacts
    /// can be initiated with
    /// `COMPLETED` state.
    initiate_as: ?InitiateAs = null,

    /// Indicates how the contact was initiated.
    ///
    /// CreateContact only supports the following initiation methods. Valid values
    /// by channel are:
    ///
    /// * For VOICE: `TRANSFER` and the subtype `connect:ExternalAudio`
    ///
    /// * For EMAIL: `OUTBOUND` | `AGENT_REPLY` | `FLOW`
    ///
    /// * For TASK: `API`
    ///
    /// The other channels listed below are incorrect. We're working to correct this
    /// information.
    initiation_method: ContactInitiationMethod,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The name of a the contact.
    name: ?[]const u8 = null,

    /// The ID of the previous contact when creating a transfer contact. This value
    /// can be provided only for external
    /// audio contacts. For more information, see [Integrate Connect Customer
    /// Contact Lens with external voice
    /// systems](https://docs.aws.amazon.com/connect/latest/adminguide/contact-lens-integration.html) in the *Connect Customer Administrator Guide*.
    previous_contact_id: ?[]const u8 = null,

    /// A formatted URL that is shown to an agent in the Contact Control Panel
    /// (CCP). Tasks can have the following
    /// reference types at the time of creation: `URL` | `NUMBER` | `STRING` |
    /// `DATE` | `EMAIL` | `ATTACHMENT`.
    references: ?[]const aws.map.MapEntry(Reference) = null,

    /// The identifier of the contact in this instance of Connect Customer.
    related_contact_id: ?[]const u8 = null,

    /// A set of system defined key-value pairs stored on individual contact
    /// segments (unique contact ID) using an
    /// attribute map. The attributes are standard Connect Customer attributes. They
    /// can be accessed in flows.
    ///
    /// Attribute keys can include only alphanumeric, -, and _.
    ///
    /// This field can be used to set Segment Contact Expiry as a duration in
    /// minutes.
    ///
    /// To set contact expiry, a ValueMap must be specified containing the integer
    /// number of minutes the contact will
    /// be active for before expiring, with `SegmentAttributes` like { `
    /// "connect:ContactExpiry":
    /// {"ValueMap" : { "ExpiryDuration": { "ValueInteger": 135}}}}`.
    segment_attributes: ?[]const aws.map.MapEntry(SegmentAttributeValue) = null,

    /// User details for the contact
    ///
    /// UserInfo is required when creating an EMAIL contact with `OUTBOUND` and
    /// `AGENT_REPLY`
    /// contact initiation methods.
    user_info: ?UserInfo = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .channel = "Channel",
        .client_token = "ClientToken",
        .description = "Description",
        .expiry_duration_in_minutes = "ExpiryDurationInMinutes",
        .initiate_as = "InitiateAs",
        .initiation_method = "InitiationMethod",
        .instance_id = "InstanceId",
        .name = "Name",
        .previous_contact_id = "PreviousContactId",
        .references = "References",
        .related_contact_id = "RelatedContactId",
        .segment_attributes = "SegmentAttributes",
        .user_info = "UserInfo",
    };
};

pub const CreateContactOutput = struct {
    /// The Amazon Resource Name (ARN) of the created contact.
    contact_arn: ?[]const u8 = null,

    /// The identifier of the contact in this instance of Connect Customer.
    contact_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_arn = "ContactArn",
        .contact_id = "ContactId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContactInput, options: CallOptions) !CreateContactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/contact/create-contact";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Channel\":");
    try aws.json.writeValue(@TypeOf(input.channel), input.channel, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.expiry_duration_in_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExpiryDurationInMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.initiate_as) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InitiateAs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InitiationMethod\":");
    try aws.json.writeValue(@TypeOf(input.initiation_method), input.initiation_method, allocator, &body_buf);
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
    if (input.previous_contact_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PreviousContactId\":");
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
    if (input.user_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UserInfo\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContactOutput {
    const result: CreateContactOutput = try aws.json.parseJsonObject(
        CreateContactOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
