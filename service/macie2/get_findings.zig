const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortCriteria = @import("sort_criteria.zig").SortCriteria;
const Finding = @import("finding.zig").Finding;

pub const GetFindingsInput = struct {
    /// An array of strings that lists the unique identifiers for the findings to
    /// retrieve. You can specify as many as 50 unique identifiers in this array.
    finding_ids: []const []const u8,

    /// The criteria for sorting the results of the request.
    sort_criteria: ?SortCriteria = null,

    pub const json_field_names = .{
        .finding_ids = "findingIds",
        .sort_criteria = "sortCriteria",
    };
};

pub const GetFindingsOutput = struct {
    /// An array of objects, one for each finding that matches the criteria
    /// specified in the request.
    findings: ?[]const Finding = null,

    pub const json_field_names = .{
        .findings = "findings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingsInput, options: CallOptions) !GetFindingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/findings/describe";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"findingIds\":");
    try aws.json.writeValue(@TypeOf(input.finding_ids), input.finding_ids, allocator, &body_buf);
    has_prev = true;
    if (input.sort_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortCriteria\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingsOutput {
    var result: GetFindingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetFindingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
