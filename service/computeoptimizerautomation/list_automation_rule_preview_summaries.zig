const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Criteria = @import("criteria.zig").Criteria;
const OrganizationScope = @import("organization_scope.zig").OrganizationScope;
const RecommendedActionType = @import("recommended_action_type.zig").RecommendedActionType;
const RuleType = @import("rule_type.zig").RuleType;
const PreviewResultSummary = @import("preview_result_summary.zig").PreviewResultSummary;

pub const ListAutomationRulePreviewSummariesInput = struct {
    criteria: ?Criteria = null,

    /// The maximum number of automation rule preview summaries to return in a
    /// single response. Valid range is 1-1000.
    max_results: ?i32 = null,

    /// A token used for pagination to retrieve the next set of results when the
    /// response is truncated.
    next_token: ?[]const u8 = null,

    /// The organizational scope for the rule preview.
    organization_scope: ?OrganizationScope = null,

    /// The types of recommended actions to include in the preview.
    recommended_action_types: []const RecommendedActionType,

    /// The type of rule.
    rule_type: RuleType,

    pub const json_field_names = .{
        .criteria = "criteria",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .organization_scope = "organizationScope",
        .recommended_action_types = "recommendedActionTypes",
        .rule_type = "ruleType",
    };
};

pub const ListAutomationRulePreviewSummariesOutput = struct {
    /// A token used for pagination. If present, indicates there are more results
    /// available and can be used in subsequent requests.
    next_token: ?[]const u8 = null,

    /// The list of automation rule preview summaries that match the specified
    /// criteria.
    preview_result_summaries: ?[]const PreviewResultSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .preview_result_summaries = "previewResultSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAutomationRulePreviewSummariesInput, options: CallOptions) !ListAutomationRulePreviewSummariesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "compute-optimizer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAutomationRulePreviewSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aco-automation", "Compute Optimizer Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerAutomationService.ListAutomationRulePreviewSummaries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAutomationRulePreviewSummariesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAutomationRulePreviewSummariesOutput, body, allocator);
}
