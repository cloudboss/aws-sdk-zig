const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortOrder = @import("sort_order.zig").SortOrder;
const HumanLoopSummary = @import("human_loop_summary.zig").HumanLoopSummary;

pub const ListHumanLoopsInput = struct {
    /// (Optional) The timestamp of the date when you want the human loops to begin
    /// in ISO 8601 format. For example, `2020-02-24`.
    creation_time_after: ?i64 = null,

    /// (Optional) The timestamp of the date before which you want the human loops
    /// to begin in ISO 8601 format. For example, `2020-02-24`.
    creation_time_before: ?i64 = null,

    /// The Amazon Resource Name (ARN) of a flow definition.
    flow_definition_arn: []const u8,

    /// The total number of items to return. If the total number of available items
    /// is more than
    /// the value specified in `MaxResults`, then a `NextToken` is returned in
    /// the output. You can use this token to display the next page of results.
    max_results: ?i32 = null,

    /// A token to display the next page of results.
    next_token: ?[]const u8 = null,

    /// Optional. The order for displaying results. Valid values: `Ascending` and
    /// `Descending`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .flow_definition_arn = "FlowDefinitionArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_order = "SortOrder",
    };
};

pub const ListHumanLoopsOutput = struct {
    /// An array of objects that contain information about the human loops.
    human_loop_summaries: ?[]const HumanLoopSummary = null,

    /// A token to display the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .human_loop_summaries = "HumanLoopSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHumanLoopsInput, options: CallOptions) !ListHumanLoopsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHumanLoopsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("a2i-runtime.sagemaker", "SageMaker A2I Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/human-loops";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.creation_time_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "CreationTimeAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.creation_time_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "CreationTimeBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "FlowDefinitionArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.flow_definition_arn);
    query_has_prev = true;
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
    if (input.sort_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "SortOrder=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHumanLoopsOutput {
    var result: ListHumanLoopsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListHumanLoopsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
