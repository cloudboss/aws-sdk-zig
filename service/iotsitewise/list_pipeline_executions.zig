const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PipelineExecutionState = @import("pipeline_execution_state.zig").PipelineExecutionState;
const PipelineExecutionSummary = @import("pipeline_execution_summary.zig").PipelineExecutionSummary;

pub const ListPipelineExecutionsInput = struct {
    /// Inclusive lower bound on execution end time (ISO-8601).
    /// Only executions with endTime >= endTimeAfter are returned.
    /// Cannot be combined with startTimeAfter or startTimeBefore.
    /// Only matches executions in terminal states.
    end_time_after: ?i64 = null,

    /// Exclusive upper bound on execution end time (ISO-8601).
    /// Only executions with endTime < endTimeBefore are returned.
    /// Cannot be combined with startTimeAfter or startTimeBefore.
    /// Only matches executions in terminal states.
    end_time_before: ?i64 = null,

    /// The maximum number of results to return per request.
    /// This is an upper bound; the actual number of results may be less. Default:
    /// 50.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    /// The name of the pipeline.
    pipeline_name: []const u8,

    /// Inclusive lower bound on execution start time (ISO-8601).
    /// Only executions with startTime >= startTimeAfter are returned.
    /// Cannot be combined with endTimeAfter or endTimeBefore.
    start_time_after: ?i64 = null,

    /// Exclusive upper bound on execution start time (ISO-8601).
    /// Only executions with startTime < startTimeBefore are returned.
    /// Cannot be combined with endTimeAfter or endTimeBefore.
    start_time_before: ?i64 = null,

    /// Filter by execution state.
    /// If not specified, executions in all states are returned.
    state: ?PipelineExecutionState = null,

    /// The name of the workspace.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .end_time_after = "endTimeAfter",
        .end_time_before = "endTimeBefore",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .pipeline_name = "pipelineName",
        .start_time_after = "startTimeAfter",
        .start_time_before = "startTimeBefore",
        .state = "state",
        .workspace_name = "workspaceName",
    };
};

pub const ListPipelineExecutionsOutput = struct {
    /// The token to be used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    /// A list that summarizes each pipeline execution.
    pipeline_execution_summaries: ?[]const PipelineExecutionSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .pipeline_execution_summaries = "pipelineExecutionSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPipelineExecutionsInput, options: CallOptions) !ListPipelineExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPipelineExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/pipelines/");
    try path_buf.appendSlice(allocator, input.pipeline_name);
    try path_buf.appendSlice(allocator, "/executions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.end_time_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endTimeAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.end_time_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endTimeBefore=");
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
    if (input.start_time_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startTimeAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.start_time_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startTimeBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.state) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "state=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPipelineExecutionsOutput {
    const result: ListPipelineExecutionsOutput = try aws.json.parseJsonObject(
        ListPipelineExecutionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
