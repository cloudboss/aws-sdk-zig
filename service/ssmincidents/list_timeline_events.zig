const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const TimelineEventSort = @import("timeline_event_sort.zig").TimelineEventSort;
const SortOrder = @import("sort_order.zig").SortOrder;
const EventSummary = @import("event_summary.zig").EventSummary;

pub const ListTimelineEventsInput = struct {
    /// Filters the timeline events based on the provided conditional values. You
    /// can filter
    /// timeline events with the following keys:
    ///
    /// * `eventReference`
    ///
    /// * `eventTime`
    ///
    /// * `eventType`
    ///
    /// Note the following when deciding how to use Filters:
    ///
    /// * If you don't specify a Filter, the response includes all timeline events.
    ///
    /// * If you specify more than one filter in a single request, the response
    ///   returns timeline
    /// events that match all filters.
    ///
    /// * If you specify a filter with more than one value, the response returns
    ///   timeline events
    /// that match any of the values provided.
    filters: ?[]const Filter = null,

    /// The Amazon Resource Name (ARN) of the incident that includes the timeline
    /// event.
    incident_record_arn: []const u8,

    /// The maximum number of results per page.
    max_results: ?i32 = null,

    /// The pagination token for the next set of items to return. (You received this
    /// token from a
    /// previous call.)
    next_token: ?[]const u8 = null,

    /// Sort timeline events by the specified key value pair.
    sort_by: ?TimelineEventSort = null,

    /// Sorts the order of timeline events by the value specified in the `sortBy`
    /// field.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .filters = "filters",
        .incident_record_arn = "incidentRecordArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};

pub const ListTimelineEventsOutput = struct {
    /// Details about each event that occurred during the incident.
    event_summaries: ?[]const EventSummary = null,

    /// The pagination token to use when requesting the next set of items. If there
    /// are no
    /// additional items to return, the string is null.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_summaries = "eventSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTimelineEventsInput, options: CallOptions) !ListTimelineEventsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTimelineEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-incidents", "SSM Incidents", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listTimelineEvents";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"incidentRecordArn\":");
    try aws.json.writeValue(@TypeOf(input.incident_record_arn), input.incident_record_arn, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortOrder\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTimelineEventsOutput {
    var result: ListTimelineEventsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListTimelineEventsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
