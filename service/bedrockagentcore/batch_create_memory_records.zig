const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemoryRecordCreateInput = @import("memory_record_create_input.zig").MemoryRecordCreateInput;
const MemoryRecordOutput = @import("memory_record_output.zig").MemoryRecordOutput;

pub const BatchCreateMemoryRecordsInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotent processing of the
    /// batch request.
    client_token: ?[]const u8 = null,

    /// The unique ID of the memory resource where records will be created.
    memory_id: []const u8,

    /// A list of memory record creation inputs to be processed in the batch
    /// operation.
    records: []const MemoryRecordCreateInput,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .memory_id = "memoryId",
        .records = "records",
    };
};

pub const BatchCreateMemoryRecordsOutput = struct {
    /// A list of memory records that failed to be created, including error details
    /// for each failure.
    failed_records: ?[]const MemoryRecordOutput = null,

    /// A list of memory records that were successfully created during the batch
    /// operation.
    successful_records: ?[]const MemoryRecordOutput = null,

    pub const json_field_names = .{
        .failed_records = "failedRecords",
        .successful_records = "successfulRecords",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateMemoryRecordsInput, options: CallOptions) !BatchCreateMemoryRecordsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateMemoryRecordsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memories/");
    try path_buf.appendSlice(allocator, input.memory_id);
    try path_buf.appendSlice(allocator, "/memoryRecords/batchCreate");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"records\":");
    try aws.json.writeValue(@TypeOf(input.records), input.records, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateMemoryRecordsOutput {
    var result: BatchCreateMemoryRecordsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchCreateMemoryRecordsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
