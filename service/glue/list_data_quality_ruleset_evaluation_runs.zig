const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataQualityRulesetEvaluationRunFilter = @import("data_quality_ruleset_evaluation_run_filter.zig").DataQualityRulesetEvaluationRunFilter;
const DataQualityRulesetEvaluationRunDescription = @import("data_quality_ruleset_evaluation_run_description.zig").DataQualityRulesetEvaluationRunDescription;

pub const ListDataQualityRulesetEvaluationRunsInput = struct {
    /// The filter criteria.
    filter: ?DataQualityRulesetEvaluationRunFilter = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// A paginated token to offset the results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListDataQualityRulesetEvaluationRunsOutput = struct {
    /// A pagination token, if more results are available.
    next_token: ?[]const u8 = null,

    /// A list of `DataQualityRulesetEvaluationRunDescription` objects representing
    /// data quality ruleset runs.
    runs: ?[]const DataQualityRulesetEvaluationRunDescription = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .runs = "Runs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataQualityRulesetEvaluationRunsInput, options: CallOptions) !ListDataQualityRulesetEvaluationRunsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataQualityRulesetEvaluationRunsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.ListDataQualityRulesetEvaluationRuns");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataQualityRulesetEvaluationRunsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDataQualityRulesetEvaluationRunsOutput, body, allocator);
}
