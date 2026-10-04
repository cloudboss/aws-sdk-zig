const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CaseEditItem = @import("case_edit_item.zig").CaseEditItem;

pub const ListCaseEditsInput = struct {
    /// Required element used with ListCaseEdits to identify the case to query.
    case_id: []const u8,

    /// Optional element to identify how many results to obtain. There is a maximum
    /// value of 25.
    max_results: ?i32 = null,

    /// An optional string that, if supplied, must be copied from the output of a
    /// previous call to ListCaseEdits. When provided in this manner, the API
    /// fetches the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .case_id = "caseId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListCaseEditsOutput = struct {
    /// Response element for ListCaseEdits that includes the action, event
    /// timestamp, message, and principal for the response.
    items: ?[]const CaseEditItem = null,

    /// An optional string that, if supplied on subsequent calls to ListCaseEdits,
    /// allows the API to fetch the next page of results.
    next_token: ?[]const u8 = null,

    /// Response element for ListCaseEdits that identifies the total number of
    /// edits.
    total: ?i32 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
        .total = "total",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCaseEditsInput, options: CallOptions) !ListCaseEditsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "security-ir", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCaseEditsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    try path_buf.appendSlice(allocator, "/list-case-edits");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCaseEditsOutput {
    var result: ListCaseEditsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListCaseEditsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
