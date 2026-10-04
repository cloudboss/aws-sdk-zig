const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigRuleComplianceFilters = @import("config_rule_compliance_filters.zig").ConfigRuleComplianceFilters;
const AggregateComplianceByConfigRule = @import("aggregate_compliance_by_config_rule.zig").AggregateComplianceByConfigRule;

pub const DescribeAggregateComplianceByConfigRulesInput = struct {
    /// The name of the configuration aggregator.
    configuration_aggregator_name: []const u8,

    /// Filters the results by ConfigRuleComplianceFilters object.
    filters: ?ConfigRuleComplianceFilters = null,

    /// The maximum number of evaluation results returned on each page.
    /// The default is
    /// maximum.
    /// If you specify 0, Config uses the default.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page that you use
    /// to get the next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_aggregator_name = "ConfigurationAggregatorName",
        .filters = "Filters",
        .limit = "Limit",
        .next_token = "NextToken",
    };
};

pub const DescribeAggregateComplianceByConfigRulesOutput = struct {
    /// Returns a list of AggregateComplianceByConfigRule
    /// object.
    aggregate_compliance_by_config_rules: ?[]const AggregateComplianceByConfigRule = null,

    /// The `nextToken` string returned on a previous page that you use
    /// to get the next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregate_compliance_by_config_rules = "AggregateComplianceByConfigRules",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAggregateComplianceByConfigRulesInput, options: CallOptions) !DescribeAggregateComplianceByConfigRulesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAggregateComplianceByConfigRulesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.DescribeAggregateComplianceByConfigRules");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAggregateComplianceByConfigRulesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAggregateComplianceByConfigRulesOutput, body, allocator);
}
