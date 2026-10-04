const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FilterCriteria = @import("filter_criteria.zig").FilterCriteria;
const SortCriteria = @import("sort_criteria.zig").SortCriteria;
const InvestigationDetail = @import("investigation_detail.zig").InvestigationDetail;

pub const ListInvestigationsInput = struct {
    /// Filters the investigation results based on a criteria.
    filter_criteria: ?FilterCriteria = null,

    /// The Amazon Resource Name (ARN) of the behavior graph.
    graph_arn: []const u8,

    /// Lists the maximum number of investigations in a page.
    max_results: ?i32 = null,

    /// Lists if there are more results available. The value of nextToken is a
    /// unique pagination token for each page. Repeat the call using the returned
    /// token to retrieve the next page. Keep all other arguments unchanged.
    ///
    /// Each pagination token expires after 24 hours. Using an expired pagination
    /// token will return a Validation Exception error.
    next_token: ?[]const u8 = null,

    /// Sorts the investigation results based on a criteria.
    sort_criteria: ?SortCriteria = null,

    pub const json_field_names = .{
        .filter_criteria = "FilterCriteria",
        .graph_arn = "GraphArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_criteria = "SortCriteria",
    };
};

pub const ListInvestigationsOutput = struct {
    /// Lists the summary of uncommon behavior or malicious activity which indicates
    /// a compromise.
    investigation_details: ?[]const InvestigationDetail = null,

    /// Lists if there are more results available. The value of nextToken is a
    /// unique pagination token for each page. Repeat the call using the returned
    /// token to retrieve the next page. Keep all other arguments unchanged.
    ///
    /// Each pagination token expires after 24 hours.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .investigation_details = "InvestigationDetails",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInvestigationsInput, options: CallOptions) !ListInvestigationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "detective", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInvestigationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.detective", "Detective", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/investigations/listInvestigations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GraphArn\":");
    try aws.json.writeValue(@TypeOf(input.graph_arn), input.graph_arn, allocator, &body_buf);
    has_prev = true;
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
    if (input.sort_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SortCriteria\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInvestigationsOutput {
    var result: ListInvestigationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListInvestigationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
