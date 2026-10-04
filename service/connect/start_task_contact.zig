const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskAttachment = @import("task_attachment.zig").TaskAttachment;
const Reference = @import("reference.zig").Reference;
const SegmentAttributeValue = @import("segment_attribute_value.zig").SegmentAttributeValue;

pub const StartTaskContactInput = struct {
    /// List of S3 presigned URLs of task attachments and their file name. You can
    /// have a maximum of 5 attachments per task.
    attachments: ?[]const TaskAttachment = null,

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

    /// The identifier of the flow for initiating the tasks. To see the
    /// ContactFlowId in the Amazon Connect admin website, on the navigation
    /// menu go to **Routing**, **Flows**. Choose the flow. On the
    /// flow page, under the name of the flow, choose **Show additional flow
    /// information**. The
    /// ContactFlowId is the last part of the ARN, shown here in bold:
    ///
    /// arn:aws:connect:us-west-2:xxxxxxxxxxxx:instance/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/contact-flow/**846ec553-a005-41c0-8341-xxxxxxxxxxxx**
    contact_flow_id: ?[]const u8 = null,

    /// A description of the task that is shown to an agent in the Contact Control
    /// Panel (CCP).
    description: ?[]const u8 = null,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The name of a task that is shown to an agent in the Contact Control Panel
    /// (CCP).
    name: []const u8,

    /// The identifier of the previous chat, voice, or task contact. Any updates to
    /// user-defined attributes to task
    /// contacts linked using the same `PreviousContactID` will affect every contact
    /// in the chain. There can be a
    /// maximum of 12 linked task contacts in a chain.
    previous_contact_id: ?[]const u8 = null,

    /// The identifier for the quick connect. Tasks that are created by using
    /// `QuickConnectId` will use the flow that is defined
    /// on agent or queue quick connect. For more information about quick connects,
    /// see [Create quick
    /// connects](https://docs.aws.amazon.com/connect/latest/adminguide/quick-connects.html).
    quick_connect_id: ?[]const u8 = null,

    /// A formatted URL that is shown to an agent in the Contact Control Panel
    /// (CCP). Tasks can have the following
    /// reference types at the time of creation: `URL` | `NUMBER` | `STRING` |
    /// `DATE` | `EMAIL`. `ATTACHMENT` is not a supported reference type during task
    /// creation.
    references: ?[]const aws.map.MapEntry(Reference) = null,

    /// The contactId that is
    /// [related](https://docs.aws.amazon.com/connect/latest/adminguide/tasks.html#linked-tasks) to this contact. Linking tasks together by using `RelatedContactID` copies over contact
    /// attributes from the related task contact to the new task contact. All
    /// updates to user-defined attributes in the new
    /// task contact are limited to the individual contact ID, unlike what happens
    /// when tasks are linked by using
    /// `PreviousContactID`. There are no limits to the number of contacts that can
    /// be linked by using
    /// `RelatedContactId`.
    related_contact_id: ?[]const u8 = null,

    /// The timestamp, in Unix Epoch seconds format, at which to start running the
    /// inbound flow. The scheduled time cannot be in the past. It must be within up
    /// to 6 days in future.
    scheduled_time: ?i64 = null,

    /// A set of system defined key-value pairs stored on individual contact
    /// segments (unique contact ID) using an
    /// attribute map. The attributes are standard Amazon Connect attributes. They
    /// can be accessed in flows.
    ///
    /// Attribute keys can include only alphanumeric, -, and _.
    ///
    /// This field can be used to set Contact Expiry as a duration in minutes and
    /// set a UserId for the User who created
    /// a task.
    ///
    /// To set contact expiry, a ValueMap must be specified containing the integer
    /// number of minutes the contact will
    /// be active for before expiring, with `SegmentAttributes` like { `
    /// "connect:ContactExpiry":
    /// {"ValueMap" : { "ExpiryDuration": { "ValueInteger": 135}}}}`.
    ///
    /// To set the created by user, a valid AgentResourceId must be supplied, with
    /// `SegmentAttributes` like
    /// { `"connect:CreatedByUser" { "ValueString":
    /// "arn:aws:connect:us-west-2:xxxxxxxxxxxx:instance/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/agent/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"}}}`.
    segment_attributes: ?[]const aws.map.MapEntry(SegmentAttributeValue) = null,

    /// A unique identifier for the task template. For more information about task
    /// templates, see [Create task
    /// templates](https://docs.aws.amazon.com/connect/latest/adminguide/task-templates.html) in the *Amazon Connect Administrator Guide*.
    task_template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachments = "Attachments",
        .attributes = "Attributes",
        .client_token = "ClientToken",
        .contact_flow_id = "ContactFlowId",
        .description = "Description",
        .instance_id = "InstanceId",
        .name = "Name",
        .previous_contact_id = "PreviousContactId",
        .quick_connect_id = "QuickConnectId",
        .references = "References",
        .related_contact_id = "RelatedContactId",
        .scheduled_time = "ScheduledTime",
        .segment_attributes = "SegmentAttributes",
        .task_template_id = "TaskTemplateId",
    };
};

pub const StartTaskContactOutput = struct {
    /// The identifier of this contact within the Amazon Connect instance.
    contact_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_id = "ContactId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTaskContactInput, options: CallOptions) !StartTaskContactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTaskContactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/contact/task";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.previous_contact_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PreviousContactId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.quick_connect_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QuickConnectId\":");
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
    if (input.scheduled_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ScheduledTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.segment_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SegmentAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.task_template_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TaskTemplateId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTaskContactOutput {
    var result: StartTaskContactOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartTaskContactOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
