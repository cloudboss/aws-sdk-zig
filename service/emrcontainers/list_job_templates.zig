const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobTemplate = @import("job_template.zig").JobTemplate;

pub const ListJobTemplatesInput = struct {
    /// The date and time after which the job templates were created.
    created_after: ?i64 = null,

    /// The date and time before which the job templates were created.
    created_before: ?i64 = null,

    /// The maximum number of job templates that can be listed.
    max_results: ?i32 = null,

    /// The token for the next set of job templates to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListJobTemplatesOutput = struct {
    /// This output displays the token for the next set of job templates.
    next_token: ?[]const u8 = null,

    /// This output lists information about the specified job templates.
    templates: ?[]const JobTemplate = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .templates = "templates",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListJobTemplatesInput, options: CallOptions) !ListJobTemplatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "emr-containers", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("emr-containers", "EMR containers", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/jobtemplates";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.created_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "createdAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.created_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "createdBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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
