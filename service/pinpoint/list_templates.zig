const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TemplatesResponse = @import("templates_response.zig").TemplatesResponse;

pub const ListTemplatesInput = struct {
    /// The string that specifies which page of results to return in a paginated
    /// response. This parameter is not supported for application, campaign, and
    /// journey metrics.
    next_token: ?[]const u8 = null,

    /// The maximum number of items to include in each page of a paginated response.
    /// This parameter is not supported for application, campaign, and journey
    /// metrics.
    page_size: ?[]const u8 = null,

    /// The substring to match in the names of the message templates to include in
    /// the results. If you specify this value, Amazon Pinpoint returns only those
    /// templates whose names begin with the value that you specify.
    prefix: ?[]const u8 = null,

    /// The type of message template to include in the results. Valid values are:
    /// EMAIL, PUSH, SMS, and VOICE. To include all types of templates in the
    /// results, don't include this parameter in your request.
    template_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .page_size = "PageSize",
        .prefix = "Prefix",
        .template_type = "TemplateType",
    };
};

pub const ListTemplatesOutput = struct {
    templates_response: ?TemplatesResponse = null,

    pub const json_field_names = .{
        .templates_response = "TemplatesResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTemplatesInput, options: CallOptions) !ListTemplatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mobiletargeting", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTemplatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpoint", "Pinpoint", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/templates";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next-token=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.page_size) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "page-size=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "prefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.template_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "template-type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTemplatesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ListTemplatesOutput = .{};

    return result;
}
