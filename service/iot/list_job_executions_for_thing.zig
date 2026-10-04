const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobExecutionStatus = @import("job_execution_status.zig").JobExecutionStatus;
const JobExecutionSummaryForThing = @import("job_execution_summary_for_thing.zig").JobExecutionSummaryForThing;

pub const ListJobExecutionsForThingInput = struct {
    /// The unique identifier you assigned to this job when it was created.
    job_id: ?[]const u8 = null,

    /// The maximum number of results to be returned per request.
    max_results: ?i32 = null,

    /// The namespace used to indicate that a job is a customer-managed job.
    ///
    /// When you specify a value for this parameter, Amazon Web Services IoT Core
    /// sends jobs notifications to
    /// MQTT topics that contain the value in the following format.
    ///
    /// `$aws/things/*THING_NAME*/jobs/*JOB_ID*/notify-namespace-*NAMESPACE_ID*/`
    ///
    /// The `namespaceId` feature is only supported by IoT Greengrass at this time.
    /// For
    /// more information, see [Setting up IoT Greengrass core
    /// devices.](https://docs.aws.amazon.com/greengrass/v2/developerguide/setting-up.html)
    namespace_id: ?[]const u8 = null,

    /// The token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// An optional filter that lets you search for jobs that have the specified
    /// status.
    status: ?JobExecutionStatus = null,

    /// The thing name.
    thing_name: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
        .max_results = "maxResults",
        .namespace_id = "namespaceId",
        .next_token = "nextToken",
        .status = "status",
        .thing_name = "thingName",
    };
};

pub const ListJobExecutionsForThingOutput = struct {
    /// A list of job execution summaries.
    execution_summaries: ?[]const JobExecutionSummaryForThing = null,

    /// The token for the next set of results, or **null** if
    /// there are no additional results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .execution_summaries = "executionSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListJobExecutionsForThingInput, options: CallOptions) !ListJobExecutionsForThingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListJobExecutionsForThingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    try path_buf.appendSlice(allocator, "/jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.job_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "jobId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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
    if (input.namespace_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "namespaceId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListJobExecutionsForThingOutput {
    var result: ListJobExecutionsForThingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListJobExecutionsForThingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
