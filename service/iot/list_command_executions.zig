const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeFilter = @import("time_filter.zig").TimeFilter;
const CommandNamespace = @import("command_namespace.zig").CommandNamespace;
const SortOrder = @import("sort_order.zig").SortOrder;
const CommandExecutionStatus = @import("command_execution_status.zig").CommandExecutionStatus;
const CommandExecutionSummary = @import("command_execution_summary.zig").CommandExecutionSummary;

pub const ListCommandExecutionsInput = struct {
    /// The Amazon Resource Number (ARN) of the command. You can use this
    /// information to
    /// list all command executions for a particular command.
    command_arn: ?[]const u8 = null,

    /// List all command executions that completed any time before or after the
    /// date and time that you specify. The date and time uses the format
    /// `yyyy-MM-dd'T'HH:mm`.
    completed_time_filter: ?TimeFilter = null,

    /// The maximum number of results to return in this operation.
    max_results: ?i32 = null,

    /// The namespace of the command.
    namespace: ?CommandNamespace = null,

    /// To retrieve the next set of results, the `nextToken` value from a previous
    /// response; otherwise `null` to receive the first set of results.
    next_token: ?[]const u8 = null,

    /// Specify whether to list the command executions that were created in the
    /// ascending or descending order. By default, the API returns all commands in
    /// the
    /// descending order based on the start time or completion time of the
    /// executions, that are
    /// determined by the `startTimeFilter` and `completeTimeFilter`
    /// parameters.
    sort_order: ?SortOrder = null,

    /// List all command executions that started any time before or after the
    /// date and time that you specify. The date and time uses the format
    /// `yyyy-MM-dd'T'HH:mm`.
    started_time_filter: ?TimeFilter = null,

    /// List all command executions for the device that have a particular status.
    /// For example,
    /// you can filter the list to display only command executions that have failed
    /// or timed
    /// out.
    status: ?CommandExecutionStatus = null,

    /// The Amazon Resource Number (ARN) of the target device. You can use this
    /// information to
    /// list all command executions for a particular device.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .command_arn = "commandArn",
        .completed_time_filter = "completedTimeFilter",
        .max_results = "maxResults",
        .namespace = "namespace",
        .next_token = "nextToken",
        .sort_order = "sortOrder",
        .started_time_filter = "startedTimeFilter",
        .status = "status",
        .target_arn = "targetArn",
    };
};

pub const ListCommandExecutionsOutput = struct {
    /// The list of command executions.
    command_executions: ?[]const CommandExecutionSummary = null,

    /// The token to use to get the next set of results, or `null` if there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .command_executions = "commandExecutions",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCommandExecutionsInput, options: CallOptions) !ListCommandExecutionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCommandExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/command-executions";

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

    if (input.command_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"commandArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.completed_time_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"completedTimeFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.namespace) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"namespace\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortOrder\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.started_time_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"startedTimeFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCommandExecutionsOutput {
    const result: ListCommandExecutionsOutput = try aws.json.parseJsonObject(
        ListCommandExecutionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
