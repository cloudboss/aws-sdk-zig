const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SbomValidationResult = @import("sbom_validation_result.zig").SbomValidationResult;
const SbomValidationResultSummary = @import("sbom_validation_result_summary.zig").SbomValidationResultSummary;

pub const ListSbomValidationResultsInput = struct {
    /// The maximum number of results to return at one time.
    max_results: ?i32 = null,

    /// A token that can be used to retrieve the next set of results, or null if
    /// there are no additional results.
    next_token: ?[]const u8 = null,

    /// The name of the new software package.
    package_name: []const u8,

    /// The end result of the
    validation_result: ?SbomValidationResult = null,

    /// The name of the new package version.
    version_name: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .package_name = "packageName",
        .validation_result = "validationResult",
        .version_name = "versionName",
    };
};

pub const ListSbomValidationResultsOutput = struct {
    /// A token that can be used to retrieve the next set of results, or null if
    /// there are no additional results.
    next_token: ?[]const u8 = null,

    /// A summary of the validation results for each software bill of materials
    /// attached to a software package version.
    validation_result_summaries: ?[]const SbomValidationResultSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .validation_result_summaries = "validationResultSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSbomValidationResultsInput, options: CallOptions) !ListSbomValidationResultsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSbomValidationResultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packages/");
    try path_buf.appendSlice(allocator, input.package_name);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.version_name);
    try path_buf.appendSlice(allocator, "/sbom-validation-results");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.validation_result) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "validationResult=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSbomValidationResultsOutput {
    var result: ListSbomValidationResultsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSbomValidationResultsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
