const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventReference = @import("event_reference.zig").EventReference;

pub const CreateTimelineEventInput = struct {
    /// A token that ensures that a client calls the action only once with the
    /// specified
    /// details.
    client_token: ?[]const u8 = null,

    /// A short description of the event.
    event_data: []const u8,

    /// Adds one or more references to the `TimelineEvent`. A reference is an Amazon
    /// Web Services resource involved or associated with the incident. To specify a
    /// reference, enter
    /// its Amazon Resource Name (ARN). You can also specify a related item
    /// associated with a
    /// resource. For example, to specify an Amazon DynamoDB (DynamoDB) table as a
    /// resource, use the table's ARN. You can also specify an Amazon CloudWatch
    /// metric associated
    /// with the DynamoDB table as a related item.
    event_references: ?[]const EventReference = null,

    /// The timestamp for when the event occurred.
    event_time: i64,

    /// The type of event. You can create timeline events of type `Custom Event` and
    /// `Note`.
    ///
    /// To make a Note-type event appear on the *Incident notes* panel in the
    /// console, specify `eventType` as `Note`and enter the Amazon Resource Name
    /// (ARN) of the incident as the value for `eventReference`.
    event_type: []const u8,

    /// The Amazon Resource Name (ARN) of the incident record that the action adds
    /// the incident
    /// to.
    incident_record_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .event_data = "eventData",
        .event_references = "eventReferences",
        .event_time = "eventTime",
        .event_type = "eventType",
        .incident_record_arn = "incidentRecordArn",
    };
};

pub const CreateTimelineEventOutput = struct {
    /// The ID of the event for easy reference later.
    event_id: []const u8,

    /// The ARN of the incident record that you added the event to.
    incident_record_arn: []const u8,

    pub const json_field_names = .{
        .event_id = "eventId",
        .incident_record_arn = "incidentRecordArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTimelineEventInput, options: CallOptions) !CreateTimelineEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-incidents", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTimelineEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-incidents", "SSM Incidents", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/createTimelineEvent";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"eventData\":");
    try aws.json.writeValue(@TypeOf(input.event_data), input.event_data, allocator, &body_buf);
    has_prev = true;
    if (input.event_references) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"eventReferences\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"eventTime\":");
    try aws.json.writeValue(@TypeOf(input.event_time), input.event_time, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"eventType\":");
    try aws.json.writeValue(@TypeOf(input.event_type), input.event_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"incidentRecordArn\":");
    try aws.json.writeValue(@TypeOf(input.incident_record_arn), input.incident_record_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTimelineEventOutput {
    const result: CreateTimelineEventOutput = try aws.json.parseJsonObject(
        CreateTimelineEventOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
