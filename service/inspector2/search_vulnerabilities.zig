const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchVulnerabilitiesFilterCriteria = @import("search_vulnerabilities_filter_criteria.zig").SearchVulnerabilitiesFilterCriteria;
const Vulnerability = @import("vulnerability.zig").Vulnerability;

pub const SearchVulnerabilitiesInput = struct {
    /// The criteria used to filter the results of a vulnerability search.
    filter_criteria: SearchVulnerabilitiesFilterCriteria,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value
    /// of this parameter to null for the first request to a list action. For
    /// subsequent calls, use
    /// the `NextToken` value returned from the previous request to continue listing
    /// results after the first page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter_criteria = "filterCriteria",
        .next_token = "nextToken",
    };
};

pub const SearchVulnerabilitiesOutput = struct {
    /// The pagination parameter to be used on the next list operation to retrieve
    /// more
    /// items.
    next_token: ?[]const u8 = null,

    /// Details about the listed vulnerability.
    vulnerabilities: ?[]const Vulnerability = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .vulnerabilities = "vulnerabilities",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchVulnerabilitiesInput, options: CallOptions) !SearchVulnerabilitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchVulnerabilitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/vulnerabilities/search";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"filterCriteria\":");
    try aws.json.writeValue(@TypeOf(input.filter_criteria), input.filter_criteria, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchVulnerabilitiesOutput {
    var result: SearchVulnerabilitiesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchVulnerabilitiesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
