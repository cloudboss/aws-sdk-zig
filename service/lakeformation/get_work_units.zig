const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkUnitRange = @import("work_unit_range.zig").WorkUnitRange;

pub const GetWorkUnitsInput = struct {
    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// The size of each page to get in the Amazon Web Services service call. This
    /// does not affect the number of items returned in the command's output.
    /// Setting a smaller page size results in more calls to the Amazon Web Services
    /// service, retrieving fewer items in each call. This can help prevent the
    /// Amazon Web Services service calls from timing out.
    page_size: ?i32 = null,

    /// The ID of the plan query operation.
    query_id: []const u8,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .page_size = "PageSize",
        .query_id = "QueryId",
    };
};

pub const GetWorkUnitsOutput = struct {
    /// A continuation token for paginating the returned list of tokens, returned if
    /// the current segment of the list is not the last.
    next_token: ?[]const u8 = null,

    /// The ID of the plan query operation.
    query_id: []const u8,

    /// A `WorkUnitRangeList` object that specifies the valid range of work unit IDs
    /// for querying the execution service.
    work_unit_ranges: ?[]const WorkUnitRange = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .query_id = "QueryId",
        .work_unit_ranges = "WorkUnitRanges",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkUnitsInput, options: CallOptions) !GetWorkUnitsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkUnitsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetWorkUnits";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.page_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PageSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkUnitsOutput {
    const result: GetWorkUnitsOutput = try aws.json.parseJsonObject(
        GetWorkUnitsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
