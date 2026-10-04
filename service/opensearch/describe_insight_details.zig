const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InsightEntity = @import("insight_entity.zig").InsightEntity;
const InsightField = @import("insight_field.zig").InsightField;

pub const DescribeInsightDetailsInput = struct {
    /// The entity for which to retrieve insight details. Specifies the type and
    /// value of the
    /// entity, such as a domain name or Amazon Web Services account ID.
    entity: InsightEntity,

    /// The unique identifier of the insight to describe.
    insight_id: []const u8,

    /// Specifies whether to show response with HTML content in response or not.
    show_html_content: ?bool = null,

    pub const json_field_names = .{
        .entity = "Entity",
        .insight_id = "InsightId",
        .show_html_content = "ShowHtmlContent",
    };
};

pub const DescribeInsightDetailsOutput = struct {
    /// The list of fields that contain detailed information about the insight.
    fields: ?[]const InsightField = null,

    pub const json_field_names = .{
        .fields = "Fields",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInsightDetailsInput, options: CallOptions) !DescribeInsightDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInsightDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/insight-details";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Entity\":");
    try aws.json.writeValue(@TypeOf(input.entity), input.entity, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InsightId\":");
    try aws.json.writeValue(@TypeOf(input.insight_id), input.insight_id, allocator, &body_buf);
    has_prev = true;
    if (input.show_html_content) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ShowHtmlContent\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInsightDetailsOutput {
    var result: DescribeInsightDetailsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeInsightDetailsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
