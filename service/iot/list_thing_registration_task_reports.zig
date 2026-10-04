const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReportType = @import("report_type.zig").ReportType;

pub const ListThingRegistrationTaskReportsInput = struct {
    /// The maximum number of results to return per request.
    max_results: ?i32 = null,

    /// To retrieve the next set of results, the `nextToken`
    /// value from a previous response; otherwise **null** to receive
    /// the first set of results.
    next_token: ?[]const u8 = null,

    /// The type of task report.
    report_type: ReportType,

    /// The id of the task.
    task_id: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .report_type = "reportType",
        .task_id = "taskId",
    };
};

pub const ListThingRegistrationTaskReportsOutput = struct {
    /// The token to use to get the next set of results, or **null** if there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    /// The type of task report.
    report_type: ?ReportType = null,

    /// Links to the task resources.
    resource_links: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .report_type = "reportType",
        .resource_links = "resourceLinks",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListThingRegistrationTaskReportsInput, options: CallOptions) !ListThingRegistrationTaskReportsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListThingRegistrationTaskReportsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/thing-registration-tasks/");
    try path_buf.appendSlice(allocator, input.task_id);
    try path_buf.appendSlice(allocator, "/reports");
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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "reportType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.report_type.wireName());
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListThingRegistrationTaskReportsOutput {
    const result: ListThingRegistrationTaskReportsOutput = try aws.json.parseJsonObject(
        ListThingRegistrationTaskReportsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
