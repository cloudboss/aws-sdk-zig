const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConformancePackComplianceScoresFilters = @import("conformance_pack_compliance_scores_filters.zig").ConformancePackComplianceScoresFilters;
const SortBy = @import("sort_by.zig").SortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ConformancePackComplianceScore = @import("conformance_pack_compliance_score.zig").ConformancePackComplianceScore;

pub const ListConformancePackComplianceScoresInput = struct {
    /// Filters the results based on the `ConformancePackComplianceScoresFilters`.
    filters: ?ConformancePackComplianceScoresFilters = null,

    /// The maximum number of conformance pack compliance scores returned on each
    /// page.
    limit: ?i32 = null,

    /// The `nextToken` string in a prior request that you can use to get the
    /// paginated response for the next set of conformance pack compliance scores.
    next_token: ?[]const u8 = null,

    /// Sorts your conformance pack compliance scores in either ascending or
    /// descending order, depending on `SortOrder`.
    ///
    /// By default, conformance pack compliance scores are sorted in alphabetical
    /// order by name of the conformance pack.
    /// Enter `SCORE`, to sort conformance pack compliance scores by the numerical
    /// value of the compliance score.
    sort_by: ?SortBy = null,

    /// Determines the order in which conformance pack compliance scores are sorted.
    /// Either in ascending or descending order.
    ///
    /// By default, conformance pack compliance scores are sorted in alphabetical
    /// order by name of the conformance pack. Conformance pack compliance scores
    /// are sorted in reverse alphabetical order if you enter `DESCENDING`.
    ///
    /// You can sort conformance pack compliance scores by the numerical value of
    /// the compliance score by entering `SCORE` in the `SortBy` action. When
    /// compliance scores are sorted by `SCORE`, conformance packs with a compliance
    /// score of `INSUFFICIENT_DATA` will be last when sorting by ascending order
    /// and first when sorting by descending order.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .limit = "Limit",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListConformancePackComplianceScoresOutput = struct {
    /// A list of `ConformancePackComplianceScore` objects.
    conformance_pack_compliance_scores: ?[]const ConformancePackComplianceScore = null,

    /// The `nextToken` string that you can use to get the next page of results in a
    /// paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .conformance_pack_compliance_scores = "ConformancePackComplianceScores",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConformancePackComplianceScoresInput, options: CallOptions) !ListConformancePackComplianceScoresOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConformancePackComplianceScoresInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.ListConformancePackComplianceScores");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConformancePackComplianceScoresOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListConformancePackComplianceScoresOutput, body, allocator);
}
