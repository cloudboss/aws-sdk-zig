const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Operation = @import("operation.zig").Operation;

pub const GetDurableExecutionStateInput = struct {
    /// A checkpoint token that identifies the current state of the execution. This
    /// token is provided by the Lambda runtime and ensures that state retrieval is
    /// consistent with the current execution context.
    checkpoint_token: []const u8,

    /// The Amazon Resource Name (ARN) of the durable execution.
    durable_execution_arn: []const u8,

    /// If `NextMarker` was returned from a previous request, use this value to
    /// retrieve the next page of operations. Each pagination token expires after 24
    /// hours.
    marker: ?[]const u8 = null,

    /// The maximum number of operations to return per call. You can use `Marker` to
    /// retrieve additional pages of results. The default is 100 and the maximum
    /// allowed is 1000. A value of 0 uses the default.
    max_items: ?i32 = null,

    pub const json_field_names = .{
        .checkpoint_token = "CheckpointToken",
        .durable_execution_arn = "DurableExecutionArn",
        .marker = "Marker",
        .max_items = "MaxItems",
    };
};

pub const GetDurableExecutionStateOutput = struct {
    /// If present, indicates that more operations are available. Use this value as
    /// the `Marker` parameter in a subsequent request to retrieve the next page of
    /// results.
    next_marker: ?[]const u8 = null,

    /// An array of operations that represent the current state of the durable
    /// execution. Operations are ordered by their start sequence number in
    /// ascending order and include information needed for replay processing.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .next_marker = "NextMarker",
        .operations = "Operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDurableExecutionStateInput, options: CallOptions) !GetDurableExecutionStateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDurableExecutionStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-12-01/durable-executions/");
    try path_buf.appendSlice(allocator, input.durable_execution_arn);
    try path_buf.appendSlice(allocator, "/state");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "CheckpointToken=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.checkpoint_token);
    query_has_prev = true;
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDurableExecutionStateOutput {
    const result: GetDurableExecutionStateOutput = try aws.json.parseJsonObject(
        GetDurableExecutionStateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
