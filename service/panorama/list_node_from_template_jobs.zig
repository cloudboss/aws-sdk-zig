const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NodeFromTemplateJob = @import("node_from_template_job.zig").NodeFromTemplateJob;

pub const ListNodeFromTemplateJobsInput = struct {
    /// The maximum number of node from template jobs to return in one page of
    /// results.
    max_results: ?i32 = null,

    /// Specify the pagination token from a previous request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListNodeFromTemplateJobsOutput = struct {
    /// A pagination token that's included if more results are available.
    next_token: ?[]const u8 = null,

    /// A list of jobs.
    node_from_template_jobs: ?[]const NodeFromTemplateJob = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .node_from_template_jobs = "NodeFromTemplateJobs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNodeFromTemplateJobsInput, options: CallOptions) !ListNodeFromTemplateJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "panorama", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNodeFromTemplateJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/packages/template-job";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNodeFromTemplateJobsOutput {
    var result: ListNodeFromTemplateJobsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListNodeFromTemplateJobsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
