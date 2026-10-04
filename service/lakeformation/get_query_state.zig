const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryStateString = @import("query_state_string.zig").QueryStateString;

pub const GetQueryStateInput = struct {
    /// The ID of the plan query operation.
    query_id: []const u8,

    pub const json_field_names = .{
        .query_id = "QueryId",
    };
};

pub const GetQueryStateOutput = struct {
    /// An error message when the operation fails.
    @"error": ?[]const u8 = null,

    /// The state of a query previously submitted. The possible states are:
    ///
    /// * PENDING: the query is pending.
    ///
    /// * WORKUNITS_AVAILABLE: some work units are ready for retrieval and
    ///   execution.
    ///
    /// * FINISHED: the query planning finished successfully, and all work units are
    ///   ready for retrieval and execution.
    ///
    /// * ERROR: an error occurred with the query, such as an invalid query ID or a
    ///   backend error.
    state: QueryStateString,

    pub const json_field_names = .{
        .@"error" = "Error",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQueryStateInput, options: CallOptions) !GetQueryStateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQueryStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetQueryState";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"QueryId\":");
    try aws.json.writeValue(@TypeOf(input.query_id), input.query_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQueryStateOutput {
    const result: GetQueryStateOutput = try aws.json.parseJsonObject(
        GetQueryStateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
