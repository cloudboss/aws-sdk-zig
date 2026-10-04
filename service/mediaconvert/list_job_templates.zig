const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobTemplateListBy = @import("job_template_list_by.zig").JobTemplateListBy;
const Order = @import("order.zig").Order;
const JobTemplate = @import("job_template.zig").JobTemplate;

pub const ListJobTemplatesInput = struct {
    /// Optionally, specify a job template category to limit responses to only job
    /// templates from that category.
    category: ?[]const u8 = null,

    /// Optional. When you request a list of job templates, you can choose to list
    /// them alphabetically by NAME or chronologically by CREATION_DATE. If you
    /// don't specify, the service will list them by name.
    list_by: ?JobTemplateListBy = null,

    /// Optional. Number of job templates, up to twenty, that will be returned at
    /// one time.
    max_results: ?i32 = null,

    /// Use this string, provided with the response to a previous request, to
    /// request the next batch of job templates.
    next_token: ?[]const u8 = null,

    /// Optional. When you request lists of resources, you can specify whether they
    /// are sorted in ASCENDING or DESCENDING order. Default varies by resource.
    order: ?Order = null,

    pub const json_field_names = .{
        .category = "Category",
        .list_by = "ListBy",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .order = "Order",
    };
};

pub const ListJobTemplatesOutput = struct {
    /// List of Job templates.
    job_templates: ?[]const JobTemplate = null,

    /// Use this string to request the next batch of job templates.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_templates = "JobTemplates",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListJobTemplatesInput, options: CallOptions) !ListJobTemplatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconvert", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListJobTemplatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconvert", "MediaConvert", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2017-08-29/jobTemplates";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.category) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "category=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.list_by) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "listBy=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "order=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListJobTemplatesOutput {
    var result: ListJobTemplatesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListJobTemplatesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
