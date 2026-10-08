const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrderType = @import("order_type.zig").OrderType;
const JournalRecord = @import("journal_record.zig").JournalRecord;

pub const ListJournalRecordsInput = struct {
    /// The unique identifier for the agent space containing the execution
    agent_space_id: []const u8,

    /// The unique identifier of the execution whose journal records to retrieve
    execution_id: []const u8,

    /// Maximum number of records to return in a single response (1-100, default:
    /// 100)
    limit: ?i32 = null,

    /// Token for retrieving the next page of results
    next_token: ?[]const u8 = null,

    /// Sort order for the records based on timestamp (default: DESC)
    order: ?OrderType = null,

    /// Filter records by type (empty string returns all types)
    record_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .execution_id = "executionId",
        .limit = "limit",
        .next_token = "nextToken",
        .order = "order",
        .record_type = "recordType",
    };
};

pub const ListJournalRecordsOutput = struct {
    /// Token for retrieving the next page of results, if more results are available
    next_token: ?[]const u8 = null,

    /// List of journal records matching the request criteria
    records: ?[]const JournalRecord = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .records = "records",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListJournalRecordsInput, options: CallOptions) !ListJournalRecordsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aidevops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListJournalRecordsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/journal/agent-space/");
    try path_buf.appendSlice(allocator, input.agent_space_id);
    try path_buf.appendSlice(allocator, "/journalRecords");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"executionId\":");
    try aws.json.writeValue(@TypeOf(input.execution_id), input.execution_id, allocator, &body_buf);
    has_prev = true;
    if (input.limit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"limit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"order\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.record_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recordType\":");
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListJournalRecordsOutput {
    const result: ListJournalRecordsOutput = try aws.json.parseJsonObject(
        ListJournalRecordsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
