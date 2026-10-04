const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowSortCriteria = @import("workflow_sort_criteria.zig").WorkflowSortCriteria;
const WorkflowSummary = @import("workflow_summary.zig").WorkflowSummary;

pub const ListWorkflowsInput = struct {
    /// The maximum number of results to show in a single call to this API. If the
    /// number of results is larger than the number you specified, the response will
    /// include a `NextToken` element, which you can use to obtain additional
    /// results.
    max_results: ?i32 = null,

    /// A token returned from a call to this API to indicate the next batch of
    /// results to return, if any.
    next_token: ?[]const u8 = null,

    /// The name of the project in the space.
    project_name: []const u8,

    /// Information used to sort the items in the returned list.
    sort_by: ?[]const WorkflowSortCriteria = null,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .project_name = "projectName",
        .sort_by = "sortBy",
        .space_name = "spaceName",
    };
};

pub const ListWorkflowsOutput = struct {
    /// Information about the workflows in a project.
    items: ?[]const WorkflowSummary = null,

    /// A token returned from a call to this API to indicate the next batch of
    /// results to return, if any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkflowsInput, options: CallOptions) !ListWorkflowsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecatalyst", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkflowsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecatalyst", "CodeCatalyst", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/spaces/");
    try path_buf.appendSlice(allocator, input.space_name);
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.project_name);
    try path_buf.appendSlice(allocator, "/workflows");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.sort_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortBy\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkflowsOutput {
    var result: ListWorkflowsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListWorkflowsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
