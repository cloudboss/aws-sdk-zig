const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComplianceType = @import("compliance_type.zig").ComplianceType;
const AggregateEvaluationResult = @import("aggregate_evaluation_result.zig").AggregateEvaluationResult;

pub const GetAggregateComplianceDetailsByConfigRuleInput = struct {
    /// The 12-digit account ID of the source account.
    account_id: []const u8,

    /// The source region from where the data is aggregated.
    aws_region: []const u8,

    /// The resource compliance status.
    ///
    /// For the
    /// `GetAggregateComplianceDetailsByConfigRuleRequest`
    /// data type, Config supports only the `COMPLIANT`
    /// and `NON_COMPLIANT`. Config does not support the
    /// `NOT_APPLICABLE` and
    /// `INSUFFICIENT_DATA` values.
    compliance_type: ?ComplianceType = null,

    /// The name of the Config rule for which you want compliance
    /// information.
    config_rule_name: []const u8,

    /// The name of the configuration aggregator.
    configuration_aggregator_name: []const u8,

    /// The maximum number of evaluation results returned on each page.
    /// The default is 50. You cannot specify a number greater than 100. If
    /// you specify 0, Config uses the default.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page that you use
    /// to get the next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .aws_region = "AwsRegion",
        .compliance_type = "ComplianceType",
        .config_rule_name = "ConfigRuleName",
        .configuration_aggregator_name = "ConfigurationAggregatorName",
        .limit = "Limit",
        .next_token = "NextToken",
    };
};

pub const GetAggregateComplianceDetailsByConfigRuleOutput = struct {
    /// Returns an AggregateEvaluationResults object.
    aggregate_evaluation_results: ?[]const AggregateEvaluationResult = null,

    /// The `nextToken` string returned on a previous page that you use
    /// to get the next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregate_evaluation_results = "AggregateEvaluationResults",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAggregateComplianceDetailsByConfigRuleInput, options: CallOptions) !GetAggregateComplianceDetailsByConfigRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAggregateComplianceDetailsByConfigRuleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.GetAggregateComplianceDetailsByConfigRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAggregateComplianceDetailsByConfigRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAggregateComplianceDetailsByConfigRuleOutput, body, allocator);
}
