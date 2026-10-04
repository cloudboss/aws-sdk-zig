const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleExecutionFilter = @import("rule_execution_filter.zig").RuleExecutionFilter;
const RuleExecutionDetail = @import("rule_execution_detail.zig").RuleExecutionDetail;

pub const ListRuleExecutionsInput = struct {
    /// Input information used to filter rule execution history.
    filter: ?RuleExecutionFilter = null,

    /// The maximum number of results to return in a single call. To retrieve the
    /// remaining
    /// results, make another call with the returned nextToken value. Pipeline
    /// history is
    /// limited to the most recent 12 months, based on pipeline execution start
    /// times. Default
    /// value is 100.
    max_results: ?i32 = null,

    /// The token that was returned from the previous `ListRuleExecutions` call,
    /// which can be used to return the next set of rule executions in the list.
    next_token: ?[]const u8 = null,

    /// The name of the pipeline for which you want to get execution summary
    /// information.
    pipeline_name: []const u8,

    pub const json_field_names = .{
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .pipeline_name = "pipelineName",
    };
};

pub const ListRuleExecutionsOutput = struct {
    /// A token that can be used in the next `ListRuleExecutions` call. To view all
    /// items in the list, continue to call this operation with each subsequent
    /// token until no
    /// more nextToken values are returned.
    next_token: ?[]const u8 = null,

    /// Details about the output for listing rule executions.
    rule_execution_details: ?[]const RuleExecutionDetail = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .rule_execution_details = "ruleExecutionDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRuleExecutionsInput, options: CallOptions) !ListRuleExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codepipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRuleExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.ListRuleExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRuleExecutionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRuleExecutionsOutput, body, allocator);
}
