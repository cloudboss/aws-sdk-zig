const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchQuantumTasksFilter = @import("search_quantum_tasks_filter.zig").SearchQuantumTasksFilter;
const QuantumTaskSummary = @import("quantum_task_summary.zig").QuantumTaskSummary;

pub const SearchQuantumTasksInput = struct {
    /// Array of `SearchQuantumTasksFilter` objects to use when searching for
    /// quantum tasks.
    filters: []const SearchQuantumTasksFilter,

    /// Maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A token used for pagination of results returned in the response. Use the
    /// token returned from the previous request to continue search where the
    /// previous request ended.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const SearchQuantumTasksOutput = struct {
    /// A token used for pagination of results, or null if there are no additional
    /// results. Use the token value in a subsequent request to continue search
    /// where the previous request ended.
    next_token: ?[]const u8 = null,

    /// An array of `QuantumTaskSummary` objects for quantum tasks that match the
    /// specified filters.
    quantum_tasks: ?[]const QuantumTaskSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .quantum_tasks = "quantumTasks",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchQuantumTasksInput, options: CallOptions) !SearchQuantumTasksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "braket", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchQuantumTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("braket", "Braket", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/quantum-tasks";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"filters\":");
    try aws.json.writeValue(@TypeOf(input.filters), input.filters, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchQuantumTasksOutput {
    const result: SearchQuantumTasksOutput = try aws.json.parseJsonObject(
        SearchQuantumTasksOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
