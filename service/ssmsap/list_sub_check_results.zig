const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubCheckResult = @import("sub_check_result.zig").SubCheckResult;

pub const ListSubCheckResultsInput = struct {
    /// The maximum number of results to return with a single call. To retrieve the
    /// remaining results, make another call with the returned nextToken value.
    max_results: ?i32 = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    /// The ID of the configuration check operation.
    operation_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .operation_id = "OperationId",
    };
};

pub const ListSubCheckResultsOutput = struct {
    /// The token to use to retrieve the next page of results. This value is null
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// The sub-check results of a configuration check operation.
    sub_check_results: ?[]const SubCheckResult = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .sub_check_results = "SubCheckResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSubCheckResultsInput, options: CallOptions) !ListSubCheckResultsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-sap", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSubCheckResultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-sap", "Ssm Sap", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-sub-check-results";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OperationId\":");
    try aws.json.writeValue(@TypeOf(input.operation_id), input.operation_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSubCheckResultsOutput {
    var result: ListSubCheckResultsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSubCheckResultsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
