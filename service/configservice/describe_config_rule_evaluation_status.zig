const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigRuleEvaluationStatus = @import("config_rule_evaluation_status.zig").ConfigRuleEvaluationStatus;

pub const DescribeConfigRuleEvaluationStatusInput = struct {
    /// The name of the Config managed rules for which you want
    /// status information. If you do not specify any names, Config
    /// returns status information for all Config managed rules that you
    /// use.
    config_rule_names: ?[]const []const u8 = null,

    /// The number of rule evaluation results that you want
    /// returned.
    ///
    /// This parameter is required if the rule limit for your account
    /// is more than the default of 1000 rules.
    ///
    /// For information about requesting a rule limit increase, see
    /// [Config
    /// Limits](http://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html#limits_config) in the *Amazon Web Services General
    /// Reference Guide*.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page
    /// that you use to get the next page of results in a paginated
    /// response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .config_rule_names = "ConfigRuleNames",
        .limit = "Limit",
        .next_token = "NextToken",
    };
};

pub const DescribeConfigRuleEvaluationStatusOutput = struct {
    /// Status information about your Config managed rules.
    config_rules_evaluation_status: ?[]const ConfigRuleEvaluationStatus = null,

    /// The string that you use in a subsequent request to get the next
    /// page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .config_rules_evaluation_status = "ConfigRulesEvaluationStatus",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConfigRuleEvaluationStatusInput, options: CallOptions) !DescribeConfigRuleEvaluationStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConfigRuleEvaluationStatusInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.DescribeConfigRuleEvaluationStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConfigRuleEvaluationStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeConfigRuleEvaluationStatusOutput, body, allocator);
}
