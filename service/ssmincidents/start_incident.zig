const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RelatedItem = @import("related_item.zig").RelatedItem;
const TriggerDetails = @import("trigger_details.zig").TriggerDetails;

pub const StartIncidentInput = struct {
    /// A token ensuring that the operation is called only once with the specified
    /// details.
    client_token: ?[]const u8 = null,

    /// Defines the impact to the customers. Providing an impact overwrites the
    /// impact provided by
    /// a response plan.
    ///
    /// **Supported impact codes**
    ///
    /// * `1` - Critical
    ///
    /// * `2` - High
    ///
    /// * `3` - Medium
    ///
    /// * `4` - Low
    ///
    /// * `5` - No Impact
    impact: ?i32 = null,

    /// Add related items to the incident for other responders to use. Related items
    /// are Amazon Web Services
    /// resources, external links, or files uploaded to an Amazon S3 bucket.
    related_items: ?[]const RelatedItem = null,

    /// The Amazon Resource Name (ARN) of the response plan that pre-defines
    /// summary, chat
    /// channels, Amazon SNS topics, runbooks, title, and impact of the incident.
    response_plan_arn: []const u8,

    /// Provide a title for the incident. Providing a title overwrites the title
    /// provided by the
    /// response plan.
    title: ?[]const u8 = null,

    /// Details of what created the incident record in Incident Manager.
    trigger_details: ?TriggerDetails = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .impact = "impact",
        .related_items = "relatedItems",
        .response_plan_arn = "responsePlanArn",
        .title = "title",
        .trigger_details = "triggerDetails",
    };
};

pub const StartIncidentOutput = struct {
    /// The ARN of the newly created incident record.
    incident_record_arn: []const u8,

    pub const json_field_names = .{
        .incident_record_arn = "incidentRecordArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartIncidentInput, options: CallOptions) !StartIncidentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartIncidentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-incidents", "SSM Incidents", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/startIncident";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.impact) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impact\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.related_items) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"relatedItems\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"responsePlanArn\":");
    try aws.json.writeValue(@TypeOf(input.response_plan_arn), input.response_plan_arn, allocator, &body_buf);
    has_prev = true;
    if (input.title) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"title\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.trigger_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"triggerDetails\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartIncidentOutput {
    const result: StartIncidentOutput = try aws.json.parseJsonObject(
        StartIncidentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
